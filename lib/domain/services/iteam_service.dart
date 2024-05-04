import '../entities/Team.dart';

abstract class ITeamService {
  Future<void> createTeam(Team team);
  Future<List<Team>> getTeamsForUser(String userId);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String teamId); // New method for deleting a team
  Future<List<Team>> getAllTeams(); // New method for fetching all teams
  Future<Team> getTeamById(
      String teamId); // New method for fetching a team by its ID
}
