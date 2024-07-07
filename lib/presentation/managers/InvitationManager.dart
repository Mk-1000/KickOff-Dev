// ignore_for_file: empty_catches

import 'package:takwira/business/services/InvitationService.dart';
import 'package:takwira/business/services/TeamService.dart';
import 'package:takwira/domain/entities/Game.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

import '../../domain/entities/Chat.dart';
import '../../domain/entities/Team.dart';
import 'GameManager.dart';

class InvitationManager {
  final InvitationService _invitationService = InvitationService();
  final PlayerManager _playerManager = PlayerManager();
  final TeamService _teamManager = TeamService();
  final ChatManager _chatManager = ChatManager();
  final GameManager _gameManager = GameManager();

  Future<void> sendInvitationFromTeamToPlayer({
    required String teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      // Validate input parameters
      if (teamId.isEmpty || playerId.isEmpty || slotId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }
      // Check if the current player is the captain of the team
      bool isCaptain =
          await _teamManager.isCaptain(Player.currentPlayer!.playerId, teamId);

      if (isCaptain) {
        bool playerExistsInTeam =
            await _teamManager.checkPlayerExistenceInTeam(teamId, playerId) !=
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
        await _invitationService.createInvitation(invitation);

        // Add received invitation to player's slot asynchronously
        await _playerManager.addReceivedInvitationToSlot(
            playerId, invitation.invitationId);

        // Add sent invitation to team's slot asynchronously
        await _teamManager.addSentInvitationToSlot(
            teamId, slotId, invitation.invitationId);
      } else {
        throw Exception("You are not authorized to send invitations.");
      }
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<void> sendInvitationFromPlayerToTeam({
    required String teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      // Validate input parameters
      if (teamId.isEmpty || playerId.isEmpty || slotId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }

      // Check if the slot is public
      bool slotPublic = await _teamManager.isSlotPublic(teamId, slotId);

      // Ensure the current player is sending the invitation
      String? currentPlayerId = Player.currentPlayer?.playerId;
      if (currentPlayerId != playerId) {
        throw Exception("Current player does not match the invited player.");
      }

      // Check if the player exists in the team
      bool playerExistsInTeam =
          await _teamManager.checkPlayerExistenceInTeam(teamId, playerId) !=
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
        await _invitationService.createInvitation(invitation);

        // Add sent invitation to player's slot asynchronously
        await _playerManager.addSentInvitationToSlot(
            playerId, invitation.invitationId);

        // Add received invitation to team's slot asynchronously
        await _teamManager.addReceivedInvitationToSlot(
            teamId, slotId, invitation.invitationId);
      } else {
        throw Exception("Slot is not public.");
      }
    } catch (e) {
      // Log the error
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<void> sendInvitationFromTeamToTeam({
    required String teamSenderId,
    required String teamReceiverId,
  }) async {
    try {
      // Validate input parameters
      if (teamSenderId.isEmpty || teamReceiverId.isEmpty) {
        throw ArgumentError("Team ID, Player ID, or Slot ID cannot be empty.");
      }
      // Check if the current player is the captain of the team
      bool isCaptain = await _teamManager.isCaptain(
          Player.currentPlayer!.playerId, teamSenderId);

      if (isCaptain) {
        // check if Team have current match
        Team homeTeam = await _teamManager.getTeamById(teamSenderId);
        if (!homeTeam.isAvailable()) {
          throw Exception("Your team is already in a game.");
        }

        Team awayTeam = await _teamManager.getTeamById(
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
        await _invitationService.createInvitation(invitation);

        // Add sent invitation to team's asynchronously
        await _teamManager.addSentGameInvitationIds(
            teamSenderId, invitation.invitationId);

        // Add sent invitation to team's asynchronously
        await _teamManager.addReceivedGameInvitationIds(
            teamReceiverId, invitation.invitationId);
      } else {
        throw Exception("You are not authorized to send invitations.");
      }
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<void> respondToInvitation(String invitationId, bool accept) async {
    try {
      final invitation =
          await _invitationService.getInvitationDetails(invitationId);
      print(invitation.invitationType);
      print(InvitationType.TeamToTeam);

      if (invitation.invitationType == InvitationType.TeamToTeam) {
        // Check if the current player is the captain of the away team
        bool isAwayCaptain = await _teamManager.isCaptain(
            Player.currentPlayer!.playerId, invitation.slotId);

        if (isAwayCaptain) {
          if (accept) {
            // Check if both teams are available
            Team homeTeam = await _teamManager.getTeamById(invitation.playerId);
            Team awayTeam = await _teamManager.getTeamById(invitation.slotId);

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
            await _chatManager.createNewChat(chat);

            game.chatId = chat.chatId;

            // Create the game and update team current game IDs
            await _gameManager.createGame(game);

            homeTeam.currentGameId = game.gameId;
            awayTeam.currentGameId = game.gameId;

            await _teamManager.updateTeam(homeTeam);
            await _teamManager.updateTeam(awayTeam);
          }
        }
      } else {
        if (accept) {
          // Add player to team slot and update player's team ID
          await _teamManager.addPlayerToSlot(
              invitation.teamId!, invitation.playerId, invitation.slotId);
          await _playerManager.addTeamId(
              invitation.playerId, invitation.teamId!);
        } else {}
      }

      // Remove the processed invitation
      await removeInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to respond to invitation: $e');
    }
  }

  Future<void> removeInvitation(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);

      if (invitation.invitationType == InvitationType.TeamToPlayer) {
        await removeInvitationSentFromTeamToPlayer(invitationId);
      } else if (invitation.invitationType == InvitationType.PlayerToTeam) {
        await removeInvitationSentFromPlayerToTeam(invitationId);
      } else if (invitation.invitationType == InvitationType.TeamToTeam) {
        await removeInvitationSentFromTeamToTeam(invitationId);
      }

      await _invitationService.deleteInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<void> removeInvitationSentFromPlayerToTeam(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);
      await _playerManager.removeSentInvitation(
          invitation.playerId, invitationId);
      await _teamManager.removeReceivedInvitationFromSlot(
          invitation.teamId!, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from player: $e');
    }
  }

  Future<void> removeInvitationSentFromTeamToPlayer(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);
      await _playerManager.removeReceivedInvitation(
          invitation.playerId, invitationId);
      await _teamManager.removeSentInvitationFromSlot(
          invitation.teamId!, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from team: $e');
    }
  }

  Future<void> removeInvitationSentFromTeamToTeam(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);

      await _teamManager.removeSentGameInvitationIds(
          invitation.playerId, invitationId);
      await _teamManager.removeReceivedGameInvitationIds(
          invitation.slotId, invitationId);
      await _teamManager.removeSentGameInvitationIds(
          invitation.slotId, invitationId);
      await _teamManager.removeReceivedGameInvitationIds(
          invitation.playerId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from player: $e');
    }
  }

  Future<Invitation> fetchInvitationDetails(String invitationId) async {
    try {
      return await _invitationService.getInvitationDetails(invitationId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForPlayer(
      Player player) async {
    try {
      List<Invitation> invitations = [];
      for (String invitationId in player.receivedInvitationIds) {
        Invitation invitation =
            await _invitationService.getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch received invitations for player: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForPlayer(Player player) async {
    try {
      List<Invitation> invitations = [];
      for (String invitationId in player.sentInvitationIds) {
        Invitation invitation =
            await _invitationService.getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch sent invitations for player: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForTeam(Team team) async {
    try {
      List<Invitation> invitations = [];
      for (List<String> slotIds in team.receivedSlotInvitations.values) {
        for (String invitationId in slotIds) {
          Invitation invitation =
              await _invitationService.getInvitationDetails(invitationId);
          invitations.add(invitation);
        }
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch received invitations for team: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForTeam(Team team) async {
    try {
      List<Invitation> invitations = [];
      for (List<String> slotIds in team.sentSlotInvitations.values) {
        for (String invitationId in slotIds) {
          Invitation invitation =
              await _invitationService.getInvitationDetails(invitationId);
          invitations.add(invitation);
        }
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch sent invitations for team: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForGame(Team team) async {
    try {
      List<Invitation> invitations = [];
      for (String invitationId in team.receivedGameInvitationIds) {
        Invitation invitation =
            await _invitationService.getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch received invitations for team: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForGame(Team team) async {
    try {
      List<Invitation> invitations = [];
      for (String invitationId in team.sentGameInvitationIds) {
        Invitation invitation =
            await _invitationService.getInvitationDetails(invitationId);
        invitations.add(invitation);
      }
      return invitations;
    } catch (e) {
      throw Exception('Failed to fetch sent invitations for team: $e');
    }
  }
}
