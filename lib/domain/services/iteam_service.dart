import '../entities/Team.dart';

abstract class ITeamService {
  Future<void> createTeam(Team team);
  Future<List<Team>> getTeamsForUser(String userId);
  Future<void> updateTeam(Team team);
}
