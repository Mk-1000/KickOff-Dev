import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Team.dart';
import '../../domain/repositories/ITeamRepository.dart';
import '../firebase/FirebaseService.dart';

class TeamRepository implements ITeamRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'teams';

  TeamRepository(this._firebaseService);

  // @override
  // Future<List<Team>> getAllTeams() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> teamsMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return teamsMap.values
  //         .map((e) => Team.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Team>> getAllTeams() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final teams = <Team>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          teams.add(Team.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return teams; // Return the initially loaded teams
  }

  @override
  Future<Team> getTeamById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Team.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Team not found');
  }

  @override
  Future<void> addTeam(Team team) async {
    await _firebaseService.addDocument(_collectionPath, team.toJson());
  }

  @override
  Future<void> updateTeam(Team team) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${team.teamId}', team.toJson());
  }

  @override
  Future<void> deleteTeam(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Team>> getTeamsForUser(String userId) async {
    final List<Team> allTeams = await getAllTeams();
    return allTeams.where((team) => team.players.containsKey(userId)).toList();
  }
}
