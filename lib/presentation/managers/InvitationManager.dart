import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

import '../../domain/entities/Team.dart';

class InvitationManager {
  final InvitationService _invitationService = InvitationService();
  final PlayerManager _playerManager = PlayerManager();
  final TeamService _teamManager = TeamService();

  Future<void> sendInvitationToPlayer({
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

  Future<void> sendInvitationToTeam({
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
        await _sendInvitation(teamId, playerId, slotId);
      } else {
        throw Exception("Slot is not public.");
      }
    } catch (e, stackTrace) {
      // Log the error
      print('Error in sendInvitationToTeam: $e');
      print(stackTrace);
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<void> _sendInvitation(
      String teamId, String playerId, String slotId) async {
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
  }

  Future<void> respondToInvitation(String invitationId, bool accept) async {
    try {
      print('Responding to invitation with ID: $invitationId');

      final invitation =
          await _invitationService.getInvitationDetails(invitationId);

      if (accept) {
        print('Accepting invitation...');
        await _teamManager.addPlayerToSlot(
            invitation.teamId, invitation.playerId, invitation.slotId);
        await _playerManager.addTeamId(invitation.playerId, invitation.teamId);
      } else {
        print('Rejecting invitation...');
      }

      print('Removing invitation...');
      await removeInvitation(invitationId);

      print('Invitation responded successfully.');
    } catch (e) {
      print('Failed to respond to invitation: $e');
      throw Exception('Failed to respond to invitation: $e');
    }
  }

  Future<void> removeInvitation(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);

      try {
        if (invitation.invitationType == InvitationType.TeamToPlayer) {
          await removeInvitationSentFromTeam(invitationId);
        } else if (invitation.invitationType == InvitationType.PlayerToTeam) {
          await removeInvitationSentFromPlayer(invitationId);
        }
        // print('Removing invitation with ID: $invitationId');

        await _invitationService.deleteInvitation(invitationId);
        // print('Invitation deleted.');
      } catch (fetchError) {
        print(
            'Failed to fetch invitation details after deletion. This might be expected if the invitation was already removed: $fetchError');
      }

      // print('Invitation removal process completed.');
    } catch (e) {
      print('Failed to remove invitation: $e');
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<void> removeInvitationSentFromPlayer(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);
      await _playerManager.removeSentInvitation(
          invitation.playerId, invitationId);
      await _teamManager.removeReceivedInvitationFromSlot(
          invitation.teamId, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from player: $e');
    }
  }

  Future<void> removeInvitationSentFromTeam(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);
      await _playerManager.removeReceivedInvitation(
          invitation.playerId, invitationId);
      await _teamManager.removeSentInvitationFromSlot(
          invitation.teamId, invitation.slotId, invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation sent from team: $e');
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
}
