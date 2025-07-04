import 'package:takwira/business/services/ChatService.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/ITeamRepository.dart';
import 'package:takwira/domain/services/IChatService.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';

import '../../domain/entities/Game.dart';
import '../../domain/entities/Player.dart';
import '../../domain/services/ITeamService.dart';
import 'GameService.dart';

class TeamService implements ITeamService {
  final ITeamRepository _teamRepository;

  TeamService({ITeamRepository? teamRepository, IChatService? chatService})
      : _teamRepository = teamRepository ?? TeamRepository();

  @override
  Future<void> createTeam(Team team) async {
    await _teamRepository.addTeam(team);
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    return await _teamRepository.getTeamsForUser(userId);
  }

  @override
  Future<void> updateTeam(Team team) async {
    team.newUpdate();
    await _teamRepository.updateTeam(team);
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    await _teamRepository.deleteTeam(teamId);
  }

  @override
  Future<List<Team>> getAllTeams() async {
    return await _teamRepository.getAllTeams();
  }

  @override
  Future<Team> getTeamById(String teamId) async {
    return await _teamRepository.getTeamById(teamId);
  }

  @override
  Future<bool> isCaptain(String playerId, String teamId) async {
    try {
      Team team = await getTeamById(teamId);
      return team.captainId == playerId;
    } catch (e) {
      throw Exception('Failed to load team details: $e');
    }
  }

  @override
  Stream<List<Team>> streamTeams() {
    return _teamRepository.streamTeams();
  }

  @override
  Stream<List<Team>> getAvailableTeamForGameStream() {
    return _teamRepository.getAvailableTeamForGameStream();
  }

  @override
  Future<List<Team>> getAvailableTeamForGame() {
    return _teamRepository.getAvailableTeamForGame();
  }

  @override
  Future<void> addSentInvitationToSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addSentInvitationToSlot(slotId, invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to save invitation for team slot: $e');
    }
  }

  @override
  Future<void> addReceivedInvitationToSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addReceivedInvitationToSlot(slotId, invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to save invitation for team slot: $e');
    }
  }

  @override
  Future<bool> isSlotPublic(String teamId, String slotId) async {
    try {
      Team team = await getTeamById(teamId);
      return team.isSlotPublic(slotId); // Return the result
    } catch (e) {
      print('Error checking slot status: $e');
      // Return false or handle the error as appropriate
      return false;
    }
  }

  @override
  Future<void> updateSlotStatusToPublic(String teamId, String slotId) async {
    try {
      Team team = await getTeamById(teamId);
      team.updateSlotStatusToPublic(slotId);
      await updateTeam(team);
    } catch (e) {
      print('Error update Slot Status To Public: $e');
      // Return false or handle the error as appropriate
    }
  }

  @override
  Future<void> updateSlotStatusToPrivate(String teamId, String slotId) async {
    try {
      Team team = await getTeamById(teamId);
      team.updateSlotStatusToPrivate(slotId);
      await updateTeam(team);
    } catch (e) {
      print('Error update Slot Status To Private: $e');
      // Return false or handle the error as appropriate
    }
  }

  @override
  Future<void> removeSentInvitationFromSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.removeSentInvitationFromSlot(slotId, invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> removeReceivedInvitationFromSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.removeReceivedInvitationFromSlot(slotId, invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> addPlayerToSlot(
      String teamId, String playerId, String slotId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addPlayerToSlot(playerId, slotId);
      await updateTeam(team);
      await ChatService().addParticipantToChat(team.chatId!, playerId);
    } catch (e) {
      print('Failed to add player to slot: $e');
    }
  }

  @override
  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId) async {
    try {
      Team team = await getTeamById(teamId);
      return team.getAllSlots();
    } catch (e) {
      print('Failed to get all slots from team: $e');
      throw Exception('Failed to get all slots from team: $e');
    }
  }

  @override
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

  @override
  Stream<List<PositionSlot>> getPublicAvailableSlotsStream() {
    return _teamRepository.getPublicAvailableSlotsStream();
  }

  @override
  Future<List<PositionSlot>> getPublicAvailableSlots() async {
    return await _teamRepository.getPublicAvailableSlots();
  }

  @override
  Future<String?> checkPlayerExistenceInTeam(
      String teamId, String playerId) async {
    Team team = await getTeamById(teamId);
    return team.getPlayerPosition(playerId);
  }

  @override
  Future<void> addGameHistoryId(String teamId, String gameId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addGameHistoryId(gameId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> removeGameHistoryId(String teamId, String gameId) async {
    try {
      Team team = await getTeamById(teamId);
      team.removeGameHistoryId(gameId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> addSentGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addSentGameInvitationIds(invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> removeSentGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.removeSentGameInvitationIds(invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> addReceivedGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.addReceivedGameInvitationIds(invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> removeReceivedGameInvitationIds(
      String teamId, String invitationId) async {
    try {
      Team team = await getTeamById(teamId);
      team.removeReceivedGameInvitationIds(invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to remove invitation for team slot: $e');
    }
  }

  @override
  Future<void> cancelCurrentGameFromTeam(String teamId) async {
    try {
      // Retrieve the team details
      Team team = await getTeamById(teamId);

      // Retrieve game details
      Game game = await GameService().getGameDetails(team.currentGameId!);

      // Identify the opposing team
      Team opposingTeam;
      if (team.teamId == game.homeTeam) {
        opposingTeam = await getTeamById(game.awayTeam);
      } else {
        opposingTeam = await getTeamById(game.homeTeam);
      }
      String currentPlayer = Player.currentPlayer!.playerId;

      bool haveAuthorisation = (currentPlayer == team.captainId ||
          currentPlayer == opposingTeam.captainId);

      // Ensure the current player have Authorisation
      if (haveAuthorisation) {
        // Clear the current game for both teams
        team.currentGameId = null;
        opposingTeam.currentGameId = null;

        // Update the teams in the database
        await updateTeam(team);
        await updateTeam(opposingTeam);
      }
    } catch (e) {
      print('Failed to cancel game : $e');
    }
  }

  @override
  Future<void> confirmCurrentGameFromTeam(String teamId) async {
    try {
      // Retrieve the team details
      Team team = await getTeamById(teamId);

      // Retrieve game details
      Game game = await GameService().getGameDetails(team.currentGameId!);

      // Identify the opposing team
      Team opposingTeam;
      if (team.teamId == game.homeTeam) {
        opposingTeam = await getTeamById(game.awayTeam);
      } else {
        opposingTeam = await getTeamById(game.homeTeam);
      }
      String currentPlayer = Player.currentPlayer!.playerId;

      bool haveAuthorisation = (currentPlayer == team.captainId ||
          currentPlayer == opposingTeam.captainId);

      // Ensure the current player have Authorisation
      if (haveAuthorisation) {
        // Add the game to both teams' game history
        team.addGameHistoryId(game.gameId);
        opposingTeam.addGameHistoryId(game.gameId);

        // Clear the current game for both teams
        team.currentGameId = null;
        opposingTeam.currentGameId = null;

        // Update the teams in the database
        await updateTeam(team);
        await updateTeam(opposingTeam);
      }
    } catch (e) {
      print('Failed to confirm game: $e');
    }
  }
}
