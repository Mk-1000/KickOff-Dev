import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/repositories/ITeamRepository.dart';
import '../../domain/services/iteam_service.dart';

class TeamService implements ITeamService {
  final ITeamRepository _teamRepository;

  TeamService(this._teamRepository);

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
}
