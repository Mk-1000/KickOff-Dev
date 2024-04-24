import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Player.dart';
import '../../domain/repositories/IPlayerRepository.dart';
import '../firebase/FirebaseService.dart';

class PlayerRepository implements IPlayerRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'players';

  PlayerRepository(this._firebaseService);

  // @override
  // Future<List<Player>> getAllPlayers() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> playersMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return playersMap.values
  //         .map((e) => Player.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Player>> getAllPlayers() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
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
  }

  @override
  Future<Player> getPlayerById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Player.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Player not found');
  }

  @override
  Future<void> addPlayer(Player player) async {
    await _firebaseService.addDocument(_collectionPath, player.toJson());
  }

  @override
  Future<void> updatePlayer(Player player) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${player.playerId}', player.toJson());
  }

  @override
  Future<void> deletePlayer(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Player>> getPlayersByTeam(String teamId) async {
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

    // Since streams are async and continuous, we need to await the first matching element
    final List<Player> players = await query.first;
    return players;
  }
}
