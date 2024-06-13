import 'package:takwira/domain/entities/Invitation.dart';

abstract class IInvitationService {
  Future<void> createInvitation(Invitation invitation);
  Future<Invitation> getInvitationDetails(String invitationId);
  Future<List<Invitation>> getInvitationsByPlayer(String playerId);
  Future<List<Invitation>> getInvitationsByTeam(String teamId);
  Future<void> updateInvitation(Invitation invitation);
  Future<void> deleteInvitation(String invitationId);
}
