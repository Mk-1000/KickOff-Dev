import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Team.dart';
import '../../domain/repositories/ITeamRepository.dart';
import '../firebase/FirebaseService.dart';

class TeamRepository implements ITeamRepository {
  final String _collectionPath = 'teams';
  final FirebaseService _firebaseService; // Instance field for FirebaseService

  TeamRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Stream<List<Team>> streamTeams() {
    // Return a stream of teams from the Firebase realtime database
    return _firebaseService.getCollectionStream(_collectionPath).map((event) {
      final teamsMap = event.snapshot.value as Map<dynamic, dynamic>?;
      if (teamsMap != null) {
        return teamsMap.entries.map((e) {
          return Team.fromJson(
              Map<String, dynamic>.from(e.value as Map)..['teamId'] = e.key);
        }).toList();
      }
      return [];
    });
  }

  @override
  Future<List<Team>> getAllTeams() async {
    DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
    if (snapshot.exists && snapshot.value != null) {
      var teamsMap = snapshot.value;
      if (teamsMap is Map) {
        return teamsMap.entries
            .map((e) => Team.fromJson(
                Map<String, dynamic>.from(e.value as Map)..['teamId'] = e.key))
            .toList();
      }
    }
    return []; // Return an empty list if no valid data is found
  }

  @override
  Future<Team> getTeamById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      var teamData = snapshot.value as Map;
      return Team.fromJson(Map<String, dynamic>.from(teamData));
    } else {
      // Explicitly throw an exception if no team is found.
      throw Exception('Team not found for ID $id');
    }
  }

  @override
  Future<void> addTeam(Team team) async {
    await _firebaseService.setDocument(
        '$_collectionPath/${team.teamId}', team.toJson());
  }

  @override
  Future<void> updateTeam(Team team) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${team.teamId}', team.toJson());
  }

  @override
  Future<void> deleteTeam(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
      print(
          'Team deleted successfully: $id'); // Debugging line to confirm deletion
    } catch (e) {
      print('Failed to delete team: $e'); // Error logging
      throw Exception('Failed to delete team: $e');
    }
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    final List<Team> allTeams = await getAllTeams();
    return allTeams.where((team) => team.players.containsKey(userId)).toList();
  }
}
