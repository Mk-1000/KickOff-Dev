import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

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
      final invitation = Invitation(
        teamId: teamId,
        playerId: playerId,
        slotId: slotId,
      );

      await _invitationService.createInvitation(invitation);

      await _playerManager.addReceivedInvitationToSlot(
          playerId, invitation.invitationId);

      await _teamManager.addSentInvitationToSlot(
          teamId, slotId, invitation.invitationId);
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
      bool slotPublic = await _teamManager.isSlotPublic(teamId, slotId);
      if (slotPublic) {
        final invitation = Invitation(
          teamId: teamId,
          playerId: playerId,
          slotId: slotId,
        );

        await _invitationService.createInvitation(invitation);

        await _playerManager.addSentInvitationToSlot(
            playerId, invitation.invitationId);
        await _teamManager.addReceivedInvitationToSlot(
            teamId, slotId, invitation.invitationId);
      }
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<void> respondToInvitation(String invitationId, bool accept) async {
    try {
      final invitation =
          await _invitationService.getInvitationDetails(invitationId);

      if (accept) {
        invitation.accept();
        await _teamManager.addPlayerToSlot(
            invitation.teamId, invitation.playerId, invitation.slotId);
        await _playerManager.addTeamId(invitation.playerId, invitation.teamId);
      } else {
        invitation.reject();
      }

      await _invitationService.updateInvitation(invitation);
    } catch (e) {
      throw Exception('Failed to respond to invitation: $e');
    }
  }

  Future<void> removeInvitation(String invitationId) async {
    try {
      await _invitationService.deleteInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<void> removeInvitationSendFromPlayer(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);
      await _playerManager.removeSentInvitation(
          invitation.playerId, invitationId);

      await _teamManager.removeReceivedInvitationFromSlot(
          invitation.teamId, invitation.slotId, invitationId);

      await removeInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<void> removeInvitationSendFromTeam(String invitationId) async {
    try {
      Invitation invitation = await fetchInvitationDetails(invitationId);

      await _playerManager.removeReceivedInvitation(
          invitation.playerId, invitationId);

      await _teamManager.removeSentInvitationFromSlot(
          invitation.teamId, invitation.slotId, invitationId);

      await removeInvitation(invitationId);
    } catch (e) {
      throw Exception('Failed to remove invitation: $e');
    }
  }

  Future<Invitation> fetchInvitationDetails(String invitationId) async {
    try {
      return await _invitationService.getInvitationDetails(invitationId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchInvitationsForPlayer(String playerId) async {
    try {
      return await _invitationService.getInvitationsByPlayer(playerId);
    } catch (e) {
      throw Exception('Failed to fetch invitations for player: $e');
    }
  }

  Future<List<Invitation>> fetchInvitationsForTeam(String teamId) async {
    try {
      return await _invitationService.getInvitationsByTeam(teamId);
    } catch (e) {
      throw Exception('Failed to fetch invitations for team: $e');
    }
  }
}
