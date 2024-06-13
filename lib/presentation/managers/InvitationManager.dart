import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/services/iinvitation_service.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class InvitationManager {
  final IInvitationService _invitationService = InvitationService();
  final PlayerManager playerManager = PlayerManager();
  final TeamManager teamManager = TeamManager();

  Future<void> sendInvitation({
    required String teamId,
    required String playerId,
    required String slotId,
    required Position position,
  }) async {
    try {
      // Create the invitation
      final invitation = Invitation(
        teamId: teamId,
        playerId: playerId,
        slotId: slotId,
        position: position,
        sentAt: DateTime.now().millisecondsSinceEpoch,
      );

      // Save the invitation
      await _invitationService.createInvitation(invitation);

      // Save the invitation ID in player's received invitations
      await playerManager.saveInvitationForPlayer(
          playerId, invitation.invitationId);

      // Save the invitation ID for the team slot
      await teamManager.saveInvitationForTeamSlot(
          teamId, slotId, invitation.invitationId);
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  Future<Invitation> fetchInvitationDetails(String invitationId) async {
    return await _invitationService.getInvitationDetails(invitationId);
  }

  Future<List<Invitation>> fetchInvitationsForPlayer(String playerId) async {
    return await _invitationService.getInvitationsByPlayer(playerId);
  }

  Future<List<Invitation>> fetchInvitationsForTeam(String teamId) async {
    return await _invitationService.getInvitationsByTeam(teamId);
  }

  Future<void> respondToInvitation(String invitationId, bool accept) async {
    final invitation =
        await _invitationService.getInvitationDetails(invitationId);

    if (accept) {
      invitation.accept();
    } else {
      invitation.reject();
    }

    await _invitationService.updateInvitation(invitation);
  }

  Future<void> removeInvitation(String invitationId) async {
    await _invitationService.deleteInvitation(invitationId);
  }
}
