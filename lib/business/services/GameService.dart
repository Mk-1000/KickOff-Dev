import 'package:takwira/business/services/TeamService.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';

import '../../domain/entities/Game.dart';
import '../../domain/repositories/IGameRepository.dart';
import '../../domain/services/IGameService.dart';
import '../../infrastructure/repositories/GameRepository.dart';

class GameService implements IGameService {
  final IGameRepository _gameRepository;

  GameService({IGameRepository? gameRepository})
      : _gameRepository = gameRepository ?? GameRepository();

  @override
  Future<void> createGame(Game game) async {
    try {
      await _gameRepository.addGame(game);
    } catch (e) {
      throw Exception('Failed to create game: $e');
    }
  }

  @override
  Future<Game> getGameDetails(String gameId) async {
    try {
      return await _gameRepository.getGameById(gameId);
    } catch (e) {
      throw Exception('Failed to get game details: $e');
    }
  }

  @override
  Future<void> updateGame(Game game) async {
    try {
      game.newUpdate();
      await _gameRepository.updateGame(game);
    } catch (e) {
      throw Exception('Failed to update game: $e');
    }
  }

  @override
  Future<void> deleteGame(String gameId) async {
    try {
      // Retrieve game details
      Game game = await getGameDetails(gameId);
      if (game.chatId != null) {
        // Cancel the current game for the home team
        await TeamService().cancelCurrentGameFromTeam(game.homeTeam);
        await ChatManager().deleteChat(game.chatId!);
        await _gameRepository.deleteGame(gameId);
      }
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }

  @override
  Future<void> completeGame(String gameId) async {
    try {
      // Retrieve game details
      Game game = await getGameDetails(gameId);

      // Confirm the current game for the home team
      await TeamService().confirmCurrentGameFromTeam(game.homeTeam);
    } catch (e) {
      throw Exception('Failed to complete game: $e');
    }
  }

  @override
  Future<bool> updateGameDate(String gameId, DateTime newDate) async {
    try {
      Game game = await getGameDetails(gameId);
      game.gameDate = newDate;
      await updateGame(game);
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> updateGameStadium(String gameId, String stadiumId) async {
      try {
        Game game = await getGameDetails(gameId);
        game.stadiumId = stadiumId;
        await updateGame(game);
        return true;
      } on Exception {
        return false;
      }
    }


  @override
  Future<bool> cancelGameStadium(String gameId) async {
    try {
      Game game = await getGameDetails(gameId);
      game.stadiumId = null;
      await updateGame(game);
      return true;
    } on Exception {
      return false;
    }
  }

}
