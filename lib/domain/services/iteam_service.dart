import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import '../entities/Team.dart';

abstract class ITeamService {
  Future<void> createTeam(Team team);
  Future<List<Team>> getTeamsForUser(String userId);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String teamId);
  Future<List<Team>> getAllTeams();
  Future<Team> getTeamById(String teamId);
  Stream<List<Team>> streamTeams();
  Future<void> saveInvitationForTeamSlot(
      String teamId, String slotId, String invitationId);
  Future<void> addPlayerToSlot(String playerId, String teamId, String slotId);
  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId);
  Future<Invitation?> getInvitationForSlot(String teamId, String slotId);
  Future<void> changeTeamSlotLimits(
    String teamId, {
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  });
}
