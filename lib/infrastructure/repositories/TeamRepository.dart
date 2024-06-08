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
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument(_collectionPath);
      if (snapshot.exists && snapshot.value != null) {
        var teamsMap = snapshot.value;
        if (teamsMap is Map) {
          return teamsMap.entries
              .map((e) => Team.fromJson(
                  Map<String, dynamic>.from(e.value as Map)
                    ..['teamId'] = e.key))
              .toList();
        }
      }
      return []; // Return an empty list if no valid data is found
    } catch (e) {
      print('Failed to retrieve all teams: $e');
      throw Exception('Failed to retrieve all teams');
    }
  }

  @override
  Future<Team> getTeamById(String id) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');
      if (snapshot.exists && snapshot.value != null) {
        var teamData = snapshot.value;
        if (teamData is Map<String, dynamic>) {
          return Team.fromJson(teamData);
        } else {
          throw Exception('Invalid team data format for ID $id: $teamData');
        }
      } else {
        throw Exception('Team not found for ID $id');
      }
    } catch (e) {
      print('Error fetching team by ID $id: $e');
      throw Exception('Error fetching team by ID $id: $e');
    }
  }

  @override
  Future<void> addTeam(Team team) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${team.teamId}', team.toJson());
      print('Team added successfully: ${team.teamId}');
    } catch (e) {
      print('Failed to add team: $e');
      throw Exception('Failed to add team: $e');
    }
  }

  @override
  Future<void> updateTeam(Team team) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${team.teamId}', team.toJson());
      print('Team updated successfully: ${team.teamId}');
    } catch (e) {
      print('Failed to update team: $e');
      throw Exception('Failed to update team: $e');
    }
  }

  @override
  Future<void> deleteTeam(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
      print('Team deleted successfully: $id');
    } catch (e) {
      print('Failed to delete team: $e');
      throw Exception('Failed to delete team: $e');
    }
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    try {
      final List<Team> allTeams = await getAllTeams();
      return allTeams
          .where((team) => team.players.containsKey(userId))
          .toList();
    } catch (e) {
      print('Failed to retrieve teams for user $userId: $e');
      throw Exception('Failed to retrieve teams for user');
    }
  }
}
