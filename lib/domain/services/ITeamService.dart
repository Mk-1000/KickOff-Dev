import 'package:takwira/domain/entities/PositionSlot.dart';

import '../entities/Team.dart';

abstract class ITeamService {
  Future<void> createTeam(Team team);

  Future<List<Team>> getTeamsForUser(String userId);

  Future<void> updateTeam(Team team);

  Future<void> deleteTeam(String teamId);

  Future<List<Team>> getAllTeams();

  Future<Team> getTeamById(String teamId);

  Future<bool> isCaptain(String playerId, String teamId);

  Stream<List<Team>> streamTeams();

  Future<void> updateSlotStatusToPublic(String teamId, String slotId);

  Future<void> updateSlotStatusToPrivate(String teamId, String slotId);

  Future<void> addSentInvitationToSlot(
      String teamId, String slotId, String invitationId);

  Future<void> addReceivedInvitationToSlot(
      String teamId, String slotId, String invitationId);

  Future<void> removeSentInvitationFromSlot(
      String teamId, String slotId, String invitationId);

  Future<void> removeReceivedInvitationFromSlot(
      String teamId, String slotId, String invitationId);

  Future<void> addPlayerToSlot(String playerId, String teamId, String slotId);

  Future<bool> isSlotPublic(String teamId, String slotId);

  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId);

  Future<void> changeTeamSlotLimits(
    String teamId, {
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  });

  Stream<List<PositionSlot>> getPublicAvailableSlotsStream();

  Future<List<PositionSlot>> getPublicAvailableSlots();

  Future<String?> checkPlayerExistenceInTeam(String teamId, String playerId);

  Future<void> addGameHistoryId(String teamId, String gameId);

  Future<void> removeGameHistoryId(String teamId, String gameId);

  Future<void> addSentGameInvitationIds(String teamId, String invitationId);

  Future<void> removeSentGameInvitationIds(String teamId, String invitationId);

  Future<void> addReceivedGameInvitationIds(String teamId, String invitationId);

  Future<void> removeReceivedGameInvitationIds(
      String teamId, String invitationId);

  Future<void> cancelCurrentGameFromTeam(String teamId);

  Future<void> confirmCurrentGameFromTeam(String teamId);

  Stream<List<Team>> getAvailableTeamForGameStream();

  Future<List<Team>> getAvailableTeamForGame();
}
