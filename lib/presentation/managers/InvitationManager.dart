import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class InvitationManager {
  final InvitationService _invitationService = InvitationService();
  final PlayerManager _playerManager = PlayerManager();
  final TeamManager _teamManager = TeamManager();

  Future<void> sendInvitation({
    required String teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      final invitation = Invitation(
        teamId: teamId,
        playerId: playerId,
        slotId: slotId,
        sentAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _invitationService.createInvitation(invitation);

      await _playerManager.saveInvitationForPlayer(
          playerId, invitation.invitationId);
      await _teamManager.saveInvitationForTeamSlot(
          teamId, slotId, invitation.invitationId);
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
            invitation.playerId, invitation.teamId, invitation.slotId);
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
