import 'package:takwira/business/services/team_service.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/services/iteam_service.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final ChatManager _chatManager = ChatManager();
  final PlayerManager _playerManager = PlayerManager();
  final InvitationManager _invitationManager = InvitationManager();

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

  Future<String?> checkPlayerExistenceInTeam(
      String teamId, String playerId) async {
    return _teamService.checkPlayerExistenceInTeam(teamId, playerId);
  }

  Future<void> loadTeamDetails(String teamId) async {
    try {
      _currentTeam = await _teamService.getTeamById(teamId);
    } catch (e) {
      throw Exception('Failed to load team details: $e');
    }
  }

  Future<bool> isCaptain(String playerId, String teamId) async {
    try {
      return await _teamService.isCaptain(playerId, teamId);
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
      player.addTeamId(team.teamId);

      await _playerManager.updatePlayer(player);

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

  Future<void> deleteAllTeamInvitations(String teamId) async {
    try {
      // Fetch the team details
      Team team = await getTeamById(teamId);

      // Delete all received slot invitations
      for (String slotId in team.receivedSlotInvitations.keys) {
        List<String> receivedInvitations =
            team.receivedSlotInvitations[slotId]!;
        for (String invitationId in receivedInvitations) {
          await _invitationManager.removeInvitation(invitationId);
        }
        team.receivedSlotInvitations[slotId] = [];
      }

      // Delete all sent slot invitations
      for (String slotId in team.sentSlotInvitations.keys) {
        List<String> sentInvitations = team.sentSlotInvitations[slotId]!;
        for (String invitationId in sentInvitations) {
          await _invitationManager.removeInvitation(invitationId);
        }
        team.sentSlotInvitations[slotId] = [];
      }

      // Update the team to clear all invitations
      await updateTeam(team);
    } catch (e) {
      print('Failed to delete all team invitations: $e');
      throw Exception('Failed to delete all team invitations: $e');
    }
  }

  Future<void> deleteTeamForPlayer(String teamId, String playerId) async {
    try {
      // Check if the current player is the captain of the team
      bool isCaptain =
          await _teamService.isCaptain(Player.currentPlayer!.playerId, teamId);

      if (isCaptain) {
        // Fetch the team by its ID
        Team? team = await _teamService.getTeamById(teamId);

        // Delete all invitations
        await deleteAllTeamInvitations(teamId);
        await Future.delayed(Duration(seconds: 1));

        // Delete the chat associated with the team, if any
        await _chatManager.deleteChat(team.chat!);

        // Remove the team ID from all players associated with the team
        for (String playerId in team.players) {
          _playerManager.removeTeamId(playerId, teamId);
        }

        // Remove the team ID from the current player
        // player.removeTeamId(teamId);
        // await _playerManager.updatePlayer(player);

        // Delete the team
        await deleteTeam(teamId);
      }
    } catch (e) {
      print('Failed to delete team for player: $e');
      throw Exception('Failed to delete team for player: $e');
    }
  }

  Future<Team> getTeamById(String teamId) async {
    Team? team = await _teamService.getTeamById(teamId);
    return team;
  }

  Future<List<Team>> getAllTeamsForPlayer(List<String> teamIds) async {
    List<Team> teams = [];
    for (String teamId in teamIds) {
      try {
        Team team = await getTeamById(teamId);
        teams.add(team);
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
        type: ChatType.TeamChat,
      );

      await _chatManager.createChatForTeam(teamChat);

      // Set the chat ID in the team if the chat ID is available
      team.chat = teamChat.chatId;

      PositionSlot slot = team.slots!.firstWhere(
        (slot) =>
            slot.position == player.preferredPosition &&
            slot.status == SlotStatus.Available,
        orElse: () => throw Exception('No available slot found'),
      );

      // Add the player to the slot
      team.addPlayerToSlot(player.playerId, slot.slotId);

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
    return await _teamService.changeTeamSlotLimits(teamId,
        newMaxDefenders: newMaxDefenders,
        newMaxMidfielders: newMaxMidfielders,
        newMaxForwards: newMaxForwards);
  }

  Future<void> addSentInvitationToSlot(
      String teamId, String slotId, String invitationId) async {
    return await _teamService.addSentInvitationToSlot(
        teamId, slotId, invitationId);
  }

  Future<void> addReceivedInvitationToSlot(
      String teamId, String slotId, String invitationId) async {
    return await _teamService.addReceivedInvitationToSlot(
        teamId, slotId, invitationId);
  }

  Future<void> removeSentInvitationFromSlot(
      String teamId, String slotId, String invitationId) async {
    return await _teamService.removeSentInvitationFromSlot(
        teamId, slotId, invitationId);
  }

  Future<void> removeReceivedInvitationFromSlot(
      String teamId, String slotId, String invitationId) async {
    return await _teamService.removeReceivedInvitationFromSlot(
        teamId, slotId, invitationId);
  }

  Future<void> addPlayerToSlot(
      String teamId, String playerId, String slotId) async {
    return await _teamService.addPlayerToSlot(teamId, playerId, slotId);
  }

  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId) async {
    return await _teamService.getAllSlotsFromTeam(teamId);
  }

  Future<void> updateSlotStatusToPublic(String teamId, String slotId) async {
    return await _teamService.updateSlotStatusToPublic(teamId, slotId);
  }

  Future<void> updateSlotStatusToPrivate(String teamId, String slotId) async {
    return await _teamService.updateSlotStatusToPrivate(teamId, slotId);
  }

  Stream<List<PositionSlot>> getPublicAvailableSlotsStream() {
    return _teamService.getPublicAvailableSlotsStream();
  }

  Future<List<PositionSlot>> getPublicAvailableSlots() async {
    return await _teamService.getPublicAvailableSlots();
  }
}
