import 'dart:convert';

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
  Future<void> addTeam(Team team) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${team.teamId}', team.toJson());
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  @override
  Future<void> updateTeam(Team team) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${team.teamId}', team.toJson());
    } catch (e) {
      throw Exception('Failed to update team: $e');
    }
  }

  @override
  Future<void> deleteTeam(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
    } catch (e) {
      throw Exception('Failed to delete team: $e');
    }
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    try {
      final List<Team> allTeams = await getAllTeams();
      return allTeams.where((team) {
        // Check if the player's ID is present in any slot
        return team.slots!.any((slot) => slot.playerId == userId);
      }).toList();
    } catch (e) {
      throw Exception('Failed to retrieve teams for user');
    }
  }

  @override
  Future<Team> getTeamById(String id) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');

      if (snapshot.exists && snapshot.value != null) {
        var teamData = snapshot.value;

        // Check if teamData is a Map or a JSON string
        if (teamData is Map) {
          return Team.fromJson(Map<String, dynamic>.from(teamData));
        } else if (teamData is String) {
          Map<String, dynamic> teamMap = json.decode(teamData);
          return Team.fromJson(teamMap);
        } else {
          throw Exception('Unexpected data format for team data: $teamData');
        }
      } else {
        throw Exception('Player not found for ID $id');
      }
    } catch (e) {
      throw Exception('Error fetching player by ID $id: $e');
    }
  }
}
