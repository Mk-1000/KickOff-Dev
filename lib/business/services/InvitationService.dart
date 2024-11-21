import 'package:takwira/business/services/GameService.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/repositories/IInvitationRepository.dart';
import 'package:takwira/domain/services/IInvitationService.dart';
import 'package:takwira/infrastructure/repositories/InvitationRepository.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

import '../../domain/entities/Chat.dart';
import '../../domain/entities/Game.dart';
import '../../domain/entities/Player.dart';
import '../../domain/entities/Team.dart';
import '../../presentation/managers/PlayerManager.dart';

class InvitationService implements IInvitationService {
  final IInvitationRepository _invitationRepository;

  InvitationService({IInvitationRepository? invitationRepository})
      : _invitationRepository = invitationRepository ?? InvitationRepository();

  @override
  Future<void> createInvitation(Invitation invitation) async {
    try {
      await _invitationRepository.addInvitation(invitation);
    } catch (e) {
      throw Exception('Failed to create invitation: $e');
    }
  }

  @override
  Future<Invitation> getInvitationDetails(String invitationId) async {
    try {
      return await _invitationRepository.getInvitationById(invitationId);
    } catch (e) {
      throw Exception('Failed to get invitation details: $e');
    }
  }

  @override
  Future<List<Invitation>> getInvitationsByPlayer(String playerId) async {
    try {
      return await _invitationRepository.getInvitationsByPlayerId(playerId);
    } catch (e) {
      throw Exception('Failed to get invitations by player: $e');
    }
  }

  @override
  Future<List<Invitation>> getInvitationsByTeam(String teamId) async {
    try {
      return await _invitationRepository.getInvitationsByTeamId(teamId);
    } catch (e) {
      throw Exception('Failed to get invitations by team: $e');
    }
  }

  @override
  Future<void> updateInvitation(Invitation invitation) async {
    try {
      await _invitationRepository.updateInvitation(invitation);
    } catch (e) {
      throw Exception('Failed to update invitation: $e');
    }
  }

  @override
  Future<void> deleteInvitation(String invitationId) async {
    try {
      await _invitationRepository.deleteInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to delete invitation: $e');
    }
  }

  @override
  Future<void> sendInvitationFromTeamToPlayer({
    required String teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      // Check if the invitation is already sent
      bool isInvitationAlreadySentResult = await isInvitationAlreadySent(
        playerId: playerId,
        slotId: slotId,
        teamId: teamId,
        invitationType: InvitationType.TeamToPlayer,
      );
      if (isInvitationAlreadySentResult) {
        throw Exception("Invitation already sent.");
      }

      // Validate input parameters
      if (teamId.isEmpty || playerId.isEmpty || slotId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }

      // Check if the current player is the captain of the team
      bool isCaptain =
          await TeamManager().isCaptain(Player.currentPlayer!.playerId, teamId);

      if (isCaptain) {
        bool playerExistsInTeam =
            await TeamManager().checkPlayerExistenceInTeam(teamId, playerId) !=
                null;

        if (playerExistsInTeam) {
          throw Exception("Player already exists in the team.");
        }
        // Create an invitation
        final invitation = Invitation(
          invitationType: InvitationType.TeamToPlayer,
          teamId: teamId,
          playerId: playerId,
          slotId: slotId,
        );

        // Create the invitation asynchronously
        await createInvitation(invitation);

        // Add received invitation to player's slot asynchronously
        await PlayerManager()
            .addReceivedInvitationToSlot(playerId, invitation.invitationId);

        // Add sent invitation to team's slot asynchronously
        await TeamManager()
            .addSentInvitationToSlot(teamId, slotId, invitation.invitationId);
      } else {
        throw Exception("You are not authorized to send invitations.");
      }
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  @override
  Future<void> sendInvitationFromPlayerToTeam(
      {required String teamId,
      required String playerId,
      required String slotId}) async {
    try {
      // Check if the invitation is already sent
      bool isInvitationAlreadySentResult = await isInvitationAlreadySent(
        playerId: playerId,
        slotId: slotId,
        teamId: teamId,
        invitationType: InvitationType.PlayerToTeam,
      );
      if (isInvitationAlreadySentResult) {
        throw Exception("Invitation already sent.");
      }

      // Validate input parameters
      if (teamId.isEmpty || playerId.isEmpty || slotId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }

      // Check if the slot is public
      bool slotPublic = await TeamManager().isSlotPublic(teamId, slotId);

      // Ensure the current player is sending the invitation
      String? currentPlayerId = Player.currentPlayer?.playerId;
      if (currentPlayerId != playerId) {
        throw Exception("Current player does not match the invited player.");
      }

      // Check if the player exists in the team
      bool playerExistsInTeam =
          await TeamManager().checkPlayerExistenceInTeam(teamId, playerId) !=
              null;
      if (playerExistsInTeam) {
        throw Exception("Player already exists in the team.");
      }

      // Proceed with sending the invitation if conditions are met
      if (slotPublic) {
        final invitation = Invitation(
          invitationType: InvitationType.PlayerToTeam,
          teamId: teamId,
          playerId: playerId,
          slotId: slotId,
        );

        // Create the invitation asynchronously
        await createInvitation(invitation);

        // Add sent invitation to player's slot asynchronously
        await PlayerManager()
            .addSentInvitationToSlot(playerId, invitation.invitationId);

        // Add received invitation to team's slot asynchronously
        await TeamManager().addReceivedInvitationToSlot(
            teamId, slotId, invitation.invitationId);
      } else {
        throw Exception("Slot is not public.");
      }
    } catch (e) {
      // Log the error
      throw Exception('Failed to send invitation: $e');
    }
  }

  @override
  Future<void> sendInvitationFromTeamToTeam(
      {required String teamSenderId, required String teamReceiverId}) async {
    try {
      // Check if the invitation is already sent
      bool isInvitationAlreadySentResult = await isInvitationAlreadySent(
        playerId: teamSenderId,
        slotId: teamReceiverId,
        invitationType: InvitationType.TeamToTeam,
      );
      if (isInvitationAlreadySentResult) {
        throw Exception("Invitation already sent.");
      }

      // Validate input parameters
      if (teamSenderId.isEmpty || teamReceiverId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }
      // Check if the current player is the captain of the team
      bool isCaptain = await TeamManager()
          .isCaptain(Player.currentPlayer!.playerId, teamSenderId);

      if (isCaptain) {
        // check if Team have current match
        Team homeTeam = await TeamManager().getTeamById(teamSenderId);
        if (!homeTeam.isAvailable()) {
          throw Exception("Your team is already in a game.");
        }

        Team awayTeam = await TeamManager().getTeamById(
            teamReceiverId); // Updated from teamSenderId to teamReceiverId
        if (!awayTeam.isAvailable()) {
          throw Exception("The other team is already in a game.");
        }

        if (awayTeam.players.contains(homeTeam.captainId) ||
            homeTeam.players.contains(awayTeam.captainId)) {
          throw Exception("captain  can be in the both teams.");
        }

        // Create an invitation
        final invitation = Invitation(
          invitationType: InvitationType.TeamToTeam,
          playerId: teamSenderId,
          slotId: teamReceiverId,
        );

        // Create the invitation asynchronously
        await createInvitation(invitation);

        // Add sent invitation to team's asynchronously
        await TeamManager()
            .addSentGameInvitationIds(teamSenderId, invitation.invitationId);

        // Add sent invitation to team's asynchronously
        await TeamManager().addReceivedGameInvitationIds(
            teamReceiverId, invitation.invitationId);
      } else {
        throw Exception("You are not authorized to send invitations.");
      }
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  @override
  Future<void> respondToInvitation(String invitationId, bool accept) async {
    try {
      final invitation = await getInvitationDetails(invitationId);
      print(invitation.invitationType);
      print(InvitationType.TeamToTeam);

      if (invitation.invitationType == InvitationType.TeamToTeam) {
        // Check if the current player is the captain of the away team
        bool isAwayCaptain = await TeamManager()
            .isCaptain(Player.currentPlayer!.playerId, invitation.slotId);

        if (isAwayCaptain) {
          if (accept) {
            // Check if both teams are available
            Team homeTeam =
                await TeamManager().getTeamById(invitation.playerId);
            Team awayTeam = await TeamManager().getTeamById(invitation.slotId);

            if (!homeTeam.isAvailable()) {
              throw Exception("Your team is already in a game.");
            }

            if (!awayTeam.isAvailable()) {
              throw Exception("The other team is already in a game.");
            }

            // Create a new game
            Game game = Game(
              homeTeam: invitation.playerId,
              awayTeam: invitation.slotId,
              gameStatus: GameStatus.Pending, // Default status if not provided
            );

            // Create a new chat for the teams
            Chat chat = Chat(
              participants: [...awayTeam.players, ...homeTeam.players],
              type: ChatType.VsChat,
              distinationId: game.gameId,
            );
            await ChatManager().createNewChat(chat);

            game.chatId = chat.chatId;

            // Create the game and update team current game IDs
            await GameService().createGame(game);

            homeTeam.currentGameId = game.gameId;
            awayTeam.currentGameId = game.gameId;

            await TeamManager().updateTeam(homeTeam);
            await TeamManager().updateTeam(awayTeam);
          }
        }
      } else {
        if (accept) {
          // Add player to team slot and update player's team ID
          await TeamManager().addPlayerToSlot(
              invitation.teamId!, invitation.playerId, invitation.slotId);
          await PlayerManager()
              .addTeamId(invitation.playerId, invitation.teamId!);
        } else {}
      }

      // Remove the processed invitation
      await removeInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to respond to invitation: $e');
    }
  }

  @override
  Future<void> removeInvitation(String invitationId) async {
    try {
      Invitation invitation = await getInvitationDetails(invitationId);

      if (invitation.invitationType == InvitationType.TeamToPlayer) {
        await _removeInvitationSentFromTeamToPlayer(invitationId);
      } else if (invitation.invitationType == InvitationType.PlayerToTeam) {
        await _removeInvitationSentFromPlayerToTeam(invitationId);
      } else if (invitation.invitationType == InvitationType.TeamToTeam) {
        await _removeInvitationSentFromTeamToTeam(invitationId);
      }

      await deleteInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<void> _removeInvitationSentFromPlayerToTeam(
      String invitationId) async {
    try {
      Invitation invitation = await getInvitationDetails(invitationId);
      await PlayerManager()
          .removeSentInvitation(invitation.playerId, invitationId);
      await TeamManager().removeReceivedInvitationFromSlot(
          invitation.teamId!, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from player: $e');
    }
  }

  Future<void> _removeInvitationSentFromTeamToPlayer(
      String invitationId) async {
    try {
      Invitation invitation = await getInvitationDetails(invitationId);
      await PlayerManager()
          .removeReceivedInvitation(invitation.playerId, invitationId);
      await TeamManager().removeSentInvitationFromSlot(
          invitation.teamId!, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from team: $e');
    }
  }

  Future<void> _removeInvitationSentFromTeamToTeam(String invitationId) async {
    try {
      Invitation invitation = await getInvitationDetails(invitationId);

      await TeamManager()
          .removeSentGameInvitationIds(invitation.playerId, invitationId);
      await TeamManager()
          .removeReceivedGameInvitationIds(invitation.slotId, invitationId);
      await TeamManager()
          .removeSentGameInvitationIds(invitation.slotId, invitationId);
      await TeamManager()
          .removeReceivedGameInvitationIds(invitation.playerId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from player: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchSentInvitationsForPlayer(
      String playerId) async {
    try {
      Player player = await PlayerManager().getPlayerDetails(playerId);
      // Check if the player ID matches the current player's ID
      if (playerId != Player.currentPlayer!.playerId) {
        return []; // Return an empty list if the IDs do not match
      }
      // Check if the player has sent any invitations
      if (player.sentInvitationIds.isEmpty) {
        return []; // Return an empty list if there are no sent invitations
      }
      List<Invitation> invitations = [];
      // Fetch details for each sent invitation
      for (String invitationId in player.sentInvitationIds) {
        Invitation invitation = await getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      // Handle any exceptions that may occur
      throw Exception('Failed to fetch sent invitations for player: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchReceivedInvitationsForPlayer(
      String playerId) async {
    try {
      Player player = await PlayerManager().getPlayerDetails(playerId);

      // Check if the player has received any invitations
      if (player.receivedInvitationIds.isEmpty) {
        return []; // Return an empty list if there are no received invitations
      }
      List<Invitation> invitations = [];
      // Fetch details for each received invitation
      for (String invitationId in player.receivedInvitationIds) {
        Invitation invitation = await getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      // Handle any exceptions that may occur
      throw Exception('Failed to fetch received invitations for player: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchReceivedInvitationsForTeam(
      String teamId) async {
    try {
      Team team = await TeamManager().getTeamById(teamId);

      // Check if the current player is the captain of the team
      if (team.captainId != Player.currentPlayer!.playerId) {
        throw Exception('Current player is not the captain of the team');
      }
      // Check if the team has received any invitations
      if (team.receivedSlotInvitations.isEmpty) {
        return []; // Return an empty list if there are no received invitations
      }
      List<Invitation> invitations = [];
      // Fetch details for each received invitation
      for (List<String> slotIds in team.receivedSlotInvitations.values) {
        for (String invitationId in slotIds) {
          Invitation invitation = await getInvitationDetails(invitationId);
          invitations.add(invitation);
        }
      }
      return invitations;
    } catch (e) {
      // Handle any exceptions that may occur
      throw Exception('Failed to fetch received invitations for team: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchSentInvitationsForTeam(String teamId) async {
    try {
      Team team = await TeamManager().getTeamById(teamId);

      // Check if the team has sent any invitations
      if (team.sentSlotInvitations.isEmpty) {
        return []; // Return an empty list if there are no sent invitations
      }
      List<Invitation> invitations = [];
      // Fetch details for each sent invitation
      for (List<String> slotIds in team.sentSlotInvitations.values) {
        for (String invitationId in slotIds) {
          Invitation invitation = await getInvitationDetails(invitationId);
          invitations.add(invitation);
        }
      }
      return invitations;
    } catch (e) {
      // Handle any exceptions that may occur
      throw Exception('Failed to fetch sent invitations for team: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchReceivedInvitationsForGame(
      String teamId) async {
    Team team = await TeamManager().getTeamById(teamId);

    try {
      List<Invitation> invitations = [];
      for (String invitationId in team.receivedGameInvitationIds) {
        Invitation invitation = await getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch received invitations for team: $e');
    }
  }

  @override
  Future<List<Invitation>> fetchSentInvitationsForGame(String teamId) async {
    try {
      Team team = await TeamManager().getTeamById(teamId);

      List<Invitation> invitations = [];
      for (String invitationId in team.sentGameInvitationIds) {
        Invitation invitation = await getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch sent invitations for team: $e');
    }
  }

  @override
  Future<bool> isInvitationAlreadySent({
    required String playerId,
    required String slotId,
    required InvitationType invitationType,
    String? teamId,
  }) async {
    try {
      List<Invitation> existingInvitations = await _fetchInvitations(
        slotId: slotId,
        playerId: playerId,
        invitationType: invitationType,
        teamId: teamId,
      );

      return existingInvitations.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check existing invitations: $e');
    }
  }

  Future<List<Invitation>> _fetchInvitations({
    String? teamId,
    required String slotId,
    required String playerId,
    required InvitationType invitationType,
  }) async {
    print(
        "Fetching invitations - playerId: $playerId, teamId: $teamId, slotId: $slotId, invitationType: $invitationType");

    List<Invitation> allInvitations = [];

    try {
      switch (invitationType) {
        case InvitationType.PlayerToTeam:
          if (teamId != null) {
            allInvitations = await fetchSentInvitationsForPlayer(playerId);
          }
          break;
        case InvitationType.TeamToPlayer:
          if (teamId != null) {
            allInvitations = await fetchSentInvitationsForTeam(teamId);
          }
          break;
        case InvitationType.TeamToTeam:
          allInvitations = await fetchSentInvitationsForGame(playerId);
          break;
      }
    } catch (e) {
      print("Error fetching invitations: $e");
      // You might want to handle this error based on your application's needs
      throw Exception('Error fetching invitations: $e');
    }

    print("Fetched invitations: $allInvitations");

    return allInvitations.where((invitation) {
      return invitation.slotId == slotId &&
          invitation.playerId == playerId &&
          invitation.invitationType == invitationType;
    }).toList();
  }

  @override
  Future<String> searchInvitationId({
    required String playerId,
    required String slotId,
    required InvitationType invitationType,
    String? teamId,
  }) async {
    try {
      List<Invitation> existingInvitations = await _fetchInvitations(
        slotId: slotId,
        playerId: playerId,
        invitationType: invitationType,
        teamId: teamId,
      );

      if (existingInvitations.isNotEmpty) {
        return existingInvitations.first.invitationId;
      } else {
        throw Exception('No invitation found');
      }
    } catch (e) {
      throw Exception('Failed to get invitation ID: $e');
    }
  }
}
