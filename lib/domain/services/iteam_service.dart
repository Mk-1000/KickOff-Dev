import '../entities/Team.dart';

abstract class ITeamService {
  Future<void> createTeam(Team team);
  Future<List<Team>> getTeamsForUser(String userId);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String teamId);
  Future<List<Team>> getAllTeams();
  Future<Team> getTeamById(String teamId);
  Stream<List<Team>> streamTeams();
}
