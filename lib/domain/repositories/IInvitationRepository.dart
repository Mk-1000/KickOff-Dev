import '../entities/Invitation.dart';

abstract class IInvitationRepository {
  Future<List<Invitation>> getAllInvitations();
  Future<Invitation> getInvitationById(String id);
  Future<void> addInvitation(Invitation invitation);
  Future<void> updateInvitation(Invitation invitation);
  Future<void> deleteInvitation(String id);
  Future<List<Invitation>> getInvitationsByUser(String userId);
}
