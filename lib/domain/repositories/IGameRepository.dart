import 'package:takwira/domain/entities/Game.dart';

abstract class IGameRepository {
  Future<void> addGame(Game game);
  Future<Game> getGameById(String gameId);
  Future<void> updateGame(Game game);
  Future<void> deleteGame(String gameId);
}
