import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/services/iteam_service.dart';
import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final ChatManager _chatManager = ChatManager();
  final PlayerManager _playerManager = PlayerManager();
  final InvitationService _invitationService = InvitationService();

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
      if (team.teamId != null) {
        player.addTeamId(team.teamId);

        await _playerManager.updatePlayer(player);
      }

      await _teamService.createTeam(team);
      _teams.add(team);
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
      // Fetch the team by its ID
      Team? team = await _teamService.getTeamById(teamId);

      if (team == null) {
        throw Exception('Team not found');
      }

      // Delete the chat associated with the team, if any
      if (team.chat != null) {
        await _chatManager.deleteChat(team.chat!);
      }

      // Remove the team ID from the player's list of team IDs
      player.removeTeamId(teamId);

      // Update the player in the database
      await _playerManager.updatePlayer(player);

      await deleteTeam(teamId);

      print('Team, chat, and player records updated successfully');
    } catch (e) {
      print('Failed to delete team for player: $e');
      throw Exception('Failed to delete team for player: $e');
    }
  }

  Future<Team> getTeamById(String teamId) async {
    try {
      Team? team = await _teamService.getTeamById(teamId);
      if (team == null) {
        throw Exception('No team found for ID $teamId');
      }
      return team;
    } catch (e) {
      throw Exception('Failed to fetch team with ID $teamId: $e');
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
      }
    }
    return teams;
  }

  Future<void> createTeamForPlayer(Team team, Player player) async {
    try {
      team.slots = team.initializeSlotsList(
          goalkeepers: team.maxGoalkeepers,
          defenders: team.maxDefenders,
          midfielders: team.maxMidfielders,
          forwards: team.maxForwards);

      // Create a new chat for the team
      Chat teamChat = Chat(
        participants: [player.playerId],
        type: ChatType.public,
      );

      await _chatManager.createChatForTeam(teamChat);

      // Set the chat ID in the team if the chat ID is available
      team.chat = teamChat.chatId;

      // Assuming the player will be added as a goalkeeper with number 1
      PositionSlot goalkeeperSlot = team.slots!.firstWhere(
        (slot) =>
            slot.position == player.preferredPosition &&
            slot.status == SlotStatus.Available,
        orElse: () => throw Exception('No available goalkeeper slot found'),
      );

      // Add the player to the goalkeeper slot
      goalkeeperSlot.playerId = player.playerId;
      goalkeeperSlot.status = SlotStatus.Reserved;

      // Update team's updatedAt timestamp
      team.updatedAt = DateTime.now().millisecondsSinceEpoch;

      // Create the team
      await _teamService.createTeam(team);
      _teams.add(team);

      // Add team ID to player's team list
      player.addTeamId(team.teamId);
      await _playerManager.updatePlayer(player);
    } catch (e) {
      throw Exception('Failed to create team for player: $e');
    }
  }

  Future<void> changeTeamSlotLimits(
    String teamId, {
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  }) async {
    try {
      Team team = await getTeamById(teamId);

      team.changeSlotLimits(
        newMaxDefenders: newMaxDefenders,
        newMaxMidfielders: newMaxMidfielders,
        newMaxForwards: newMaxForwards,
      );

      await updateTeam(team);
      print('Team slot limits updated successfully');
    } catch (e) {
      print('Failed to change team slot limits: $e');
      throw Exception('Failed to change team slot limits: $e');
    }
  }

  Future<Invitation?> getInvitationForSlot(String teamId, String slotId) async {
    try {
      final team =
          await TeamService().getTeamById(teamId); // Get the team by ID
      if (team != null && team.slots!.any((slot) => slot.slotId == slotId)) {
        // Check if the slot exists in the team
        final invitationIds = team.slotInvitations?[slotId];
        if (invitationIds != null && invitationIds.isNotEmpty) {
          // Assuming you want to return the first invitation in the list
          final invitationId = invitationIds.first;
          final invitation =
              await _invitationService.getInvitationDetails(invitationId);
          return invitation;
        } else {
          print('No invitations found for slot $slotId');
        }
      } else {
        print('Team or slot not found');
      }
    } catch (e) {
      print('Error retrieving invitation: $e');
    }
    return null; // Return null if no invitation is found
  }

  Future<void> saveInvitationForTeamSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      final team = await getTeamById(teamId);
      print('teeeam' + team.toJson().toString());
      if (team != null) {
        team.addInvitationToSlot(
            slotId, invitationId); // Add invitation to the slot
        await updateTeam(team);
      } else {
        throw Exception('Team not found');
      }
    } catch (e) {
      print('Failed to save invitation for team slot: $e');
      // Handle the error as per your application's requirements
    }
  }

  Future<void> addPlayerToSlot(
      String playerId, String teamId, String slotId) async {
    try {
      final team = await getTeamById(teamId); // Get the team by ID
      if (team != null) {
        team.addPlayerToSlot(playerId, slotId); // Add player to the slot
        await updateTeam(team); // Update the team
      } else {
        throw Exception('Team not found');
      }
    } catch (e) {
      print('Failed to add player to slot: $e');
      // Handle the error as per your application's requirements
    }
  }

  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId) async {
    try {
      final teamManager = TeamManager(); // Instantiate TeamManager
      final team = await teamManager
          .getTeamById(teamId); // Get the team by ID using TeamManager
      if (team != null) {
        return team.getAllSlots(); // Return all slots from the team
      } else {
        throw Exception('Team not found');
      }
    } catch (e) {
      print('Failed to get all slots from team: $e');
      throw Exception(
          'Failed to get all slots from team: $e'); // Rethrow the exception
    }
  }
}
