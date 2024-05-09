import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Player.dart';
import '../../domain/repositories/IPlayerRepository.dart';
import '../firebase/FirebaseService.dart';

class PlayerRepository implements IPlayerRepository {
  final String _collectionPath = 'players';
  final FirebaseService _firebaseService; // Instance field for FirebaseService

  PlayerRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<List<Player>> getAllPlayers() async {
    try {
      final Stream<DatabaseEvent> stream =
          _firebaseService.getCollectionStream(_collectionPath);
      final players = <Player>[];
      stream.listen((event) {
        if (event.snapshot.exists) {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            players.add(Player.fromJson(Map<String, dynamic>.from(value)));
          });
        }
      });
      return players; // Return the initially loaded players
    } catch (e) {
      print('Failed to retrieve all players: $e');
      throw Exception('Failed to retrieve all players');
    }
  }

  @override
  Future<void> addPlayer(Player player) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${player.playerId}', player.toJson());
      print('Player added successfully: ${player.playerId}');
    } catch (e) {
      print('Failed to add player: $e');
      throw Exception('Failed to add player: $e');
    }
  }

  @override
  Future<void> updatePlayer(Player player) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${player.playerId}', player.toJson());
      print('Player updated successfully: ${player.playerId}');
    } catch (e) {
      print('Failed to update player: $e');
      throw Exception('Failed to update player: $e');
    }
  }

  @override
  Future<void> deletePlayer(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
      print('Player deleted successfully: $id');
    } catch (e) {
      print('Failed to delete player: $e');
      throw Exception('Failed to delete player: $e');
    }
  }

  @override
  Future<List<Player>> getPlayersByTeam(String teamId) async {
    try {
      final query =
          _firebaseService.getCollectionStream(_collectionPath).map((event) {
        return (event.snapshot.value as Map<dynamic, dynamic>)
            .values
            .where(
                (value) => (value as Map<dynamic, dynamic>)['teamId'] == teamId)
            .map((value) => Player.fromJson(
                Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
            .toList();
      });
      final List<Player> players = await query.first;
      return players;
    } catch (e) {
      print('Failed to retrieve players by team $teamId: $e');
      throw Exception('Failed to retrieve players by team $teamId');
    }
  }

  @override
  Future<Player> getPlayerById(String id) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');
      if (snapshot.exists && snapshot.value != null) {
        var playerData = snapshot.value as Map;
        return Player.fromJson(Map<String, dynamic>.from(playerData));
      } else {
        throw Exception('Player not found for ID $id');
      }
    } catch (e) {
      print('Error fetching player by ID $id: $e');
      throw Exception('Error fetching player by ID $id: $e');
    }
  }
}
