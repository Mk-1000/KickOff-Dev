import 'package:firebase_database/firebase_database.dart';
import 'package:takwira/domain/entities/Game.dart';
import 'package:takwira/domain/repositories/IGameRepository.dart';
import 'package:takwira/infrastructure/firebase/FirebaseService.dart';

class GameRepository implements IGameRepository {
  final String _collectionPath = 'games';
  final FirebaseService _firebaseService;

  GameRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addGame(Game game) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${game.gameId}', game.toJson());
    } catch (e) {
      throw Exception('Failed to add game: $e');
    }
  }

  @override
  Future<Game> getGameById(String gameId) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$gameId');
      if (snapshot.exists && snapshot.value != null) {
        var gameData = snapshot.value as Map;
        return Game.fromJson(Map<String, dynamic>.from(gameData));
      } else {
        throw Exception('Game not found for ID $gameId');
      }
    } catch (e) {
      throw Exception('Error fetching game by ID $gameId: $e');
    }
  }

  @override
  Future<void> updateGame(Game game) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${game.gameId}', game.toJson());
    } catch (e) {
      throw Exception('Failed to update game: $e');
    }
  }

  @override
  Future<void> deleteGame(String gameId) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$gameId');
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }
}
