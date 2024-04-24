import '../entities/Invitation.dart';

abstract class IInvitationService {
  Future<void> sendInvitation(Invitation invitation);
  Future<List<Invitation>> getInvitationsByUser(String userId);
  Future<void> updateInvitationStatus(Invitation invitation);
}
