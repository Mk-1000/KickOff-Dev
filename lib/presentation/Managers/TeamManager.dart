import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/IPlayerRepository.dart';
import 'package:takwira/domain/services/iteam_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/infrastructure/repositories/PlayerRepository.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final IPlayerRepository _playerRepository = PlayerRepository();

  List<Team> _teams = [];
  Team? _currentTeam;

  List<Team> get teams => _teams;
  Team? get currentTeam => _currentTeam;

  Future<void> loadAllTeams() async {
    try {
      _teams = await _teamService.getAllTeams();
    } catch (e) {
      throw Exception('Failed to load all teams: $e');
    }
  }

  Stream<List<Team>> streamAllTeams() {
    return _teamService.streamTeams();
  }

  Future<void> loadTeamDetails(String teamId) async {
    try {
      _currentTeam = await _teamService.getTeamById(teamId);
    } catch (e) {
      throw Exception('Failed to load team details: $e');
    }
  }

  Future<void> addTeam(Team team) async {
    try {
      await _teamService.createTeam(team);
      _teams.add(team);
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  Future<void> addTeamForPlayer(Team team, Player player) async {
    try {
      // Assuming `Team` class has an ID attribute or similar
      if (team.teamId != null) {
        player
            .addTeamId(team.teamId); // Add team ID to player's list of team IDs

        // Save the updated player object if necessary, e.g., to Firebase
        // This assumes you have a method to update players
        await _playerRepository.updatePlayer(player);
      }

      // Now, create the team
      await _teamService.createTeam(team);
      _teams.add(team); // Assuming _teams is a list maintained locally
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  Future<void> updateTeam(Team team) async {
    try {
      await _teamService.updateTeam(team);
      int index = _teams.indexWhere((t) => t.teamId == team.teamId);
      if (index != -1) {
        _teams[index] = team;
      }
    } catch (e) {
      throw Exception('Failed to update team: $e');
    }
  }

  Future<List<Team>> getTeamsForPlayer(Player player) async {
    List<Team> playerTeams = [];
    for (String teamId in player.teamIds) {
      try {
        Team team = await getTeamById(teamId);
        playerTeams.add(team);
      } catch (e) {
        // Optionally handle or log the error
        print('Error fetching team with ID $teamId: $e');
      }
    }
    print("playerlength : " + playerTeams.length.toString());

    return playerTeams;
  }

  Future<void> deleteTeam(String teamId) async {
    try {
      await _teamService.deleteTeam(teamId);
      _teams.removeWhere((team) => team.teamId == teamId);
    } catch (e) {
      throw Exception('Failed to delete team: $e');
    }
  }

  Future<Team> getTeamById(String teamId) async {
    if (teamId.isEmpty) {
      throw Exception("Team ID cannot be empty.");
    }
    try {
      Team team = await _teamService.getTeamById(teamId);
      return team;
    } catch (e) {
      print('Failed to fetch team with ID $teamId: $e');
      throw Exception('Failed to fetch team: $e');
    }
  }
}
