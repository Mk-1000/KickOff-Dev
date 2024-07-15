import 'package:takwira/domain/entities/Invitation.dart';

abstract class IInvitationService {
  Future<void> createInvitation(Invitation invitation);
  Future<Invitation> getInvitationDetails(String invitationId);
  Future<List<Invitation>> getInvitationsByPlayer(String playerId);
  Future<List<Invitation>> getInvitationsByTeam(String teamId);
  Future<void> updateInvitation(Invitation invitation);
  Future<void> deleteInvitation(String invitationId);
  Future<void> sendInvitationFromTeamToPlayer({
    required String teamId,
    required String playerId,
    required String slotId,
  });
  Future<void> sendInvitationFromPlayerToTeam({
    required String teamId,
    required String playerId,
    required String slotId,
  });

  Future<void> sendInvitationFromTeamToTeam({
    required String teamSenderId,
    required String teamReceiverId,
  });

  Future<void> respondToInvitation(String invitationId, bool accept);

  Future<void> removeInvitation(String invitationId);
  Future<List<Invitation>> fetchSentInvitationsForPlayer(String playerId);
  Future<List<Invitation>> fetchReceivedInvitationsForPlayer(String playerId);
  Future<List<Invitation>> fetchReceivedInvitationsForTeam(String teamId);
  Future<List<Invitation>> fetchSentInvitationsForTeam(String teamId);
  Future<List<Invitation>> fetchReceivedInvitationsForGame(String teamId);
  Future<List<Invitation>> fetchSentInvitationsForGame(String teamId);
}
