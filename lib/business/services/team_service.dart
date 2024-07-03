import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/ITeamRepository.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';

import '../../domain/services/iteam_service.dart';

class TeamService implements ITeamService {
  final ITeamRepository _teamRepository;
  TeamService({ITeamRepository? teamRepository})
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
  Stream<List<Team>> streamTeams() {
    return _teamRepository.streamTeams();
  }

  @override
  Future<void> addSentInvitationToSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
      team.addReceivedInvitationToSlot(slotId, invitationId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to save invitation for team slot: $e');
    }
  }

  @override
  Future<bool> isSlotPublic(String teamId, String slotId) async {
    try {
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
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
      final team = await getTeamById(teamId);
      team.addPlayerToSlot(playerId, slotId);
      await updateTeam(team);
    } catch (e) {
      print('Failed to add player to slot: $e');
    }
  }

  @override
  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId) async {
    try {
      final team = await getTeamById(teamId);
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
}
