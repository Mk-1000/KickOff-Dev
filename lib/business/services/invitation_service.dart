import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Invitation.dart';
import '../../domain/repositories/IInvitationRepository.dart';
import '../../domain/services/iinvitation_service.dart';

class InvitationService implements IInvitationService {
  final IInvitationRepository _invitationRepository;

  InvitationService(this._invitationRepository);

  @override
  Future<List<Invitation>> getInvitationsByUser(String userId) async {
    try {
      return await _invitationRepository.getInvitationsByUser(userId);
    } catch (e) {
      throw Exception('Failed to get invitations by user: $e');
    }
  }

  @override
  Future<void> sendInvitation(Invitation invitation) async {
    try {
      await _invitationRepository.addInvitation(invitation);
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  @override
  Future<void> updateInvitationStatus(Invitation invitation) async {
    try {
      await _invitationRepository.updateInvitation(invitation);
    } catch (e) {
      throw Exception('Failed to update invitation status: $e');
    }
  }
}
