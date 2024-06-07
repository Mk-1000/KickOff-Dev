import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/IPlayerRepository.dart';
import 'package:takwira/domain/services/iteam_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/infrastructure/repositories/PlayerRepository.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final IPlayerRepository _playerRepository = PlayerRepository();
  final ChatManager _chatManager = ChatManager();

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

  Future<void> deleteTeamForPlayer(String teamId, Player player) async {
    try {
      // Retrieve the team to get the chat ID
      Team? team = await _teamService.getTeamById(teamId);

      if (team == null) {
        throw Exception('Team not found');
      }

      // Delete the chat associated with the team, if it exists
      if (team.chat != null) {
        await _chatManager.deleteChat(team.chat!);
      }

      // Delete the team using the team service
      await _teamService.deleteTeam(teamId);

      // Remove the team ID from the player's list of team IDs
      player.removeTeamId(teamId);

      // Update the player's data in the repository
      await _playerRepository.updatePlayer(player);

      // Remove the team from the local list if maintained
      _teams.removeWhere((t) => t.teamId == teamId);

      print('Team, chat, and player records updated successfully');
    } catch (e) {
      print('Failed to delete team for player: $e');
      throw Exception('Failed to delete team for player: $e');
    }
  }

  Future<Team> getTeamById(String teamId) async {
    if (teamId.isEmpty) {
      throw Exception("Team ID cannot be empty.");
    }
    try {
      Team? team = await _teamService.getTeamById(teamId);
      if (team == null) {
        print('No team found for ID $teamId in Firebase.');
        throw Exception('Team not found for ID $teamId');
      }
      return team;
    } catch (e) {
      print('Failed to fetch team with ID $teamId: $e');
      throw Exception('Failed to get team by ID: $e');
    }
  }

  Future<List<Team>> getAllTeamsForPlayer(List<String> teamIds) async {
    List<Team> teams = [];
    for (String teamId in teamIds) {
      try {
        Team team = await getTeamById(teamId);
        teams.add(team);
        print('Successfully fetched team with ID $teamId');
      } catch (e) {
        print('Error fetching team $teamId: $e');
        // Optionally handle partial failure scenarios here
      }
    }
    return teams;
  }

  Future<void> createTeamForPlayer(Team team, Player player) async {
    try {
      // Create a new chat for the team
      Chat teamChat = Chat(
        participants: [player.playerId],
        type: ChatType.public,
      );

      await _chatManager.createChatForTeam(teamChat);

      // Set the chat ID in the team if the chat ID is available
      team.chat = teamChat.chatId;

      // Add the creating player to the team
      team.addPlayer(player.playerId, true);

      // Create the team
      await _teamService.createTeam(team);
      _teams.add(team);

      // Add team ID to player's team list
      player.addTeamId(team.teamId);
      await _playerRepository.updatePlayer(player);
    } catch (e) {
      throw Exception('Failed to create team for player: $e');
    }
  }
}
