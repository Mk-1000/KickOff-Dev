import 'package:takwira/domain/entities/Invitation.dart';

abstract class IInvitationRepository {
  Future<void> addInvitation(Invitation invitation);
  Future<Invitation> getInvitationById(String invitationId);
  Future<List<Invitation>> getInvitationsByPlayerId(String playerId);
  Future<List<Invitation>> getInvitationsByTeamId(String teamId);
  Future<void> updateInvitation(Invitation invitation);
  Future<void> deleteInvitation(String invitationId);
}
