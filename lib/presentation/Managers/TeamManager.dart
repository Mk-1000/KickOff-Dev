import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/services/iteam_service.dart';

class TeamManager {
  final ITeamService _teamService;

  List<Team> _teams = [];

  TeamManager({ITeamService? teamService})
      : _teamService = teamService ?? TeamService();

  // Getter for teams
  List<Team> get teams => _teams;

  // Method to load all teams
  Future<void> loadAllTeams() async {
    _teams = await _teamService.getAllTeams();
  }

  // Method to load teams for a specific user
  Future<void> loadTeamsForUser(String userId) async {
    List<Team> userTeams = await _teamService.getTeamsForUser(userId);
    _teams.clear();
    _teams.addAll(userTeams);
  }

  // Method to add a new team
  Future<void> addTeam(Team team) async {
    await _teamService.createTeam(team);
    _teams.add(team);
  }

  // Method to update an existing team
  Future<void> updateTeam(Team team) async {
    await _teamService.updateTeam(team);
    int index = _teams.indexWhere((t) => t.teamId == team.teamId);
    if (index != -1) {
      _teams[index] = team;
    }
  }

  // Method to delete a team
  Future<void> deleteTeam(String teamId) async {
    await _teamService.deleteTeam(teamId);
    _teams.removeWhere((team) => team.teamId == teamId);
  }
}
