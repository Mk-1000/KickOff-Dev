import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/repositories/IInvitationRepository.dart';
import 'package:takwira/domain/services/iinvitation_service.dart';
import 'package:takwira/infrastructure/repositories/InvitationRepository.dart';

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
}
