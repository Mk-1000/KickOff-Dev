import 'package:takwira/business/services/GameService.dart';
import 'package:takwira/domain/entities/Game.dart';
import 'package:takwira/domain/services/IGameService.dart';

class GameManager {
  final IGameService _gameService = GameService();

  Future<Game> getGameDetails(String gameId) async {
    return await _gameService.getGameDetails(gameId);
  }

  Future<bool> createGame(Game game) async {
    try {
      await _gameService.createGame(game);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateGame(Game game) async {
    try {
      await _gameService.updateGame(game);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> deleteGame(String gameId) async {
    try {
      await _gameService.deleteGame(gameId);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> completeGame(String gameId) async {
    try {
      await _gameService.completeGame(gameId);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateGameDate(String gameId, DateTime newDate) async {
    return await _gameService.updateGameDate(gameId, newDate);
  }

  Future<bool> updateGameStadium(String gameId, String stadiumId) async {
    return await _gameService.updateGameStadium(gameId, stadiumId);
  }

  Future<bool> cancelGameStadium(String gameId) async {
    return await _gameService.cancelGameStadium(gameId);
  }

}
