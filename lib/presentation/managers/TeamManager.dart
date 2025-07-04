import 'package:takwira/business/services/InvitationService.dart';
import 'package:takwira/business/services/TeamService.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/services/ITeamService.dart';
import 'package:takwira/presentation/managers/AddressManager.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

class TeamManager {
  final ITeamService _teamService = TeamService();
  final ChatManager _chatManager = ChatManager();
  final PlayerManager _playerManager = PlayerManager();
  final AddressManager _addressManager = AddressManager();

  Stream<List<Team>> streamAllTeams() {
    return _teamService.streamTeams();
  }

  Future<String?> checkPlayerExistenceInTeam(
      String teamId, String playerId) async {
    return _teamService.checkPlayerExistenceInTeam(teamId, playerId);
  }

  Future<Team> loadTeamDetails(String teamId) async {
    try {
      return await _teamService.getTeamById(teamId);
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
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  Future<void> updateTeam(Team team) async {
    try {
      await _teamService.updateTeam(team);
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
        throw Exception('Failed to get team: $e');
      }
    }
    return playerTeams;
  }

  Future<void> deleteTeam(String teamId) async {
    try {
      await _teamService.deleteTeam(teamId);
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
          await InvitationService().removeInvitation(invitationId);
        }
        team.receivedSlotInvitations[slotId] = [];
      }

      // Delete all sent slot invitations
      for (String slotId in team.sentSlotInvitations.keys) {
        List<String> sentInvitations = team.sentSlotInvitations[slotId]!;
        for (String invitationId in sentInvitations) {
          await InvitationService().removeInvitation(invitationId);
        }
        team.sentSlotInvitations[slotId] = [];
      }

      // Update the team to clear all invitations
      await updateTeam(team);
    } catch (e) {
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
        await Future.delayed(const Duration(seconds: 1));

        // Delete the chat associated with the team, if any

        if (team.addressId != null) {
          await _addressManager.deleteAddress(team.addressId!);
        }

        if (team.chatId != null) {
          await _chatManager.deleteChat(team.chatId!);
        }

        // Remove the team ID from all players associated with the team
        for (String playerId in team.players) {
          _playerManager.removeTeamId(playerId, teamId);
        }
        Player.currentPlayer?.removeTeamId(teamId);

        // Delete the team
        await deleteTeam(teamId);
      }
    } catch (e) {
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
      } catch (e) {}
    }
    return teams;
  }

  Future<void> createTeamForPlayer(
      Team team, Address address, Player player) async {
    try {
      address.distinationId = team.teamId;
      team.addressId = address.addressId;

      await _addressManager.createAddress(address);

      team.slots = team.initializeSlotsList(
          goalkeepers: team.maxGoalkeepers,
          defenders: team.maxDefenders,
          midfielders: team.maxMidfielders,
          forwards: team.maxForwards);

      // Create a new chat for the team
      Chat teamChat = Chat(
        participants: [player.playerId],
        type: ChatType.TeamChat,
        distinationId: team.teamId,
      );

      await _chatManager.createChatForTeam(teamChat);

      // Set the chat ID in the team if the chat ID is available
      team.chatId = teamChat.chatId;

      PositionSlot slot = team.slots.firstWhere(
        (slot) =>
            slot.position == player.preferredPosition &&
            slot.status == SlotStatus.Available,
        orElse: () => throw Exception('No available slot found'),
      );

      // Add the player to the slot
      team.addPlayerToSlot(player.playerId, slot.slotId);

      // Create the team
      await _teamService.createTeam(team);

      // Add team ID to player's team list
      player.addTeamId(team.teamId);
      await _playerManager.updatePlayer(player);
      Player.currentPlayer?.addTeamId(team.teamId);
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

  Future<bool> addGameHistoryId(String teamId, String gameId) async {
    try {
      await _teamService.addGameHistoryId(teamId, gameId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> removeGameHistoryId(String teamId, String gameId) async {
    try {
      await _teamService.removeGameHistoryId(teamId, gameId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> addSentGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      await _teamService.addSentGameInvitationIds(teamId, invitationId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> removeSentGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      await _teamService.removeSentGameInvitationIds(teamId, invitationId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> addReceivedGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      await _teamService.addReceivedGameInvitationIds(teamId, invitationId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> removeReceivedGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      await _teamService.removeReceivedGameInvitationIds(teamId, invitationId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> cancelCurrentGameFromTeam(String teamId) async {
    try {
      await _teamService.cancelCurrentGameFromTeam(teamId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> confirmCurrentGameFromTeam(String teamId) async {
    try {
      await _teamService.confirmCurrentGameFromTeam(teamId);
      return true;
    } catch (e) {
      // Optionally, log the error or handle it accordingly
      return false;
    }
  }

  Future<bool> isSlotPublic(String teamId, String slotId) async {
    return await _teamService.isSlotPublic(teamId, slotId);
  }

  Stream<List<Team>> getAvailableTeamForGameStream() {
    return _teamService.getAvailableTeamForGameStream();
  }

  Future<List<Team>> getAvailableTeamForGame() {
    return _teamService.getAvailableTeamForGame();
  }
}
