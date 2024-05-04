import 'package:takwira/business/services/player_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/services/iplayer_service.dart';
import 'package:takwira/domain/services/iteam_service.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final IPlayerService _playerService = PlayerService();

  List<Team> _teams = [];

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
    var player = Player.currentPlayer;
    if (player != null) {
      Player.currentPlayer!.addTeamId(team.teamId);
      _playerService.updatePlayer(player);
    }
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
