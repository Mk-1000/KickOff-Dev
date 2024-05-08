import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/ITeamRepository.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';
import '../../domain/services/iteam_service.dart';

class TeamService implements ITeamService {
  final ITeamRepository _teamRepository;

  TeamService({TeamRepository? teamRepository})
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
}
