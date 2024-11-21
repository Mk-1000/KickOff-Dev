import 'package:takwira/domain/entities/Game.dart';

abstract class IGameService {
  Future<Game> getGameDetails(String gameId);
  Future<void> createGame(Game game);
  Future<void> updateGame(Game game);
  Future<void> deleteGame(String gameId);
  Future<void> completeGame(String gameId);
  Future<bool> updateGameDate(String gameId, DateTime newDate);
  Future<bool> updateGameStadium(String gameId, String stadiumId) ;
  Future<bool> cancelGameStadium(String gameId) ;
  }
