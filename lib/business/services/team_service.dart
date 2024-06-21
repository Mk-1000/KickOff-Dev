import 'package:takwira/business/services/invitation_service.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/ITeamRepository.dart';
import 'package:takwira/domain/services/iinvitation_service.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';
import '../../domain/services/iteam_service.dart';

class TeamService implements ITeamService {
  final ITeamRepository _teamRepository;
  final IInvitationService _invitationService = InvitationService();
  TeamService({ITeamRepository? teamRepository})
      : _teamRepository = teamRepository ?? TeamRepository();

  @override
  Future<void> createTeam(Team team) async {
    try {
      await _teamRepository.addTeam(team);
    } catch (e) {
      throw Exception('Failed to create team: $e');
    }
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    try {
      return await _teamRepository.getTeamsForUser(userId);
    } catch (e) {
      throw Exception('Failed to get teams for user: $e');
    }
  }

  @override
  Future<void> updateTeam(Team team) async {
    try {
      await _teamRepository.updateTeam(team);
    } catch (e) {
      throw Exception('Failed to update team: $e');
    }
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    try {
      await _teamRepository.deleteTeam(teamId);
    } catch (e) {
      throw Exception('Failed to delete team: $e');
    }
  }

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      return await _teamRepository.getAllTeams();
    } catch (e) {
      throw Exception('Failed to get all teams: $e');
    }
  }

  @override
  Future<Team> getTeamById(String teamId) async {
    try {
      return await _teamRepository.getTeamById(teamId);
    } catch (e) {
      throw Exception('Failed to get team by ID: $e');
    }
  }

  @override
  Stream<List<Team>> streamTeams() {
    try {
      return _teamRepository
          .streamTeams(); // Call the streamTeams from the repository
    } catch (e) {
      throw Exception('Failed to get team by ID: $e');
    }
  }

  @override
  Future<void> saveInvitationForTeamSlot(
      String teamId, String slotId, String invitationId) async {
    try {
      final team = await getTeamById(teamId);
      team.addInvitationToSlot(
          slotId, invitationId); // Add invitation to the slot
      await updateTeam(team);
    } catch (e) {
      print('Failed to save invitation for team slot: $e');
      // Handle the error as per your application's requirements
    }
  }

  @override
  Future<void> addPlayerToSlot(
      String playerId, String teamId, String slotId) async {
    try {
      final team = await getTeamById(teamId); // Get the team by ID
      team.addPlayerToSlot(playerId, slotId); // Add player to the slot
      await updateTeam(team); // Update the team
    } catch (e) {
      print('Failed to add player to slot: $e');
      // Handle the error as per your application's requirements
    }
  }

  @override
  Future<List<PositionSlot>> getAllSlotsFromTeam(String teamId) async {
    try {
      final team =
          await getTeamById(teamId); // Get the team by ID using TeamManager
      return team.getAllSlots(); // Return all slots from the team
    } catch (e) {
      print('Failed to get all slots from team: $e');
      throw Exception(
          'Failed to get all slots from team: $e'); // Rethrow the exception
    }
  }

  @override
  Future<Invitation?> getInvitationForSlot(String teamId, String slotId) async {
    try {
      final team = await getTeamById(teamId); // Get the team by ID
      if (team.slots!.any((slot) => slot.slotId == slotId)) {
        // Check if the slot exists in the team
        final invitationIds = team.slotInvitations?[slotId];
        if (invitationIds != null && invitationIds.isNotEmpty) {
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
}
