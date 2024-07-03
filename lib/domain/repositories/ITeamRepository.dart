import '../entities/PositionSlot.dart';
import '../entities/Team.dart';

abstract class ITeamRepository {
  Future<List<Team>> getAllTeams();
  Future<Team> getTeamById(String id);
  Future<void> addTeam(Team team);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String id);
  Future<List<Team>> getTeamsForUser(String userId);
  Stream<List<Team>> streamTeams();
  Future<List<PositionSlot>> getPublicAvailableSlots();
  Stream<List<PositionSlot>> getPublicAvailableSlotsStream();
}
