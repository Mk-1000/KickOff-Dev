import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Player.dart';
import '../../domain/repositories/IPlayerRepository.dart';
import '../../domain/services/iplayer_service.dart';

class PlayerService implements IPlayerService {
  final IPlayerRepository _playerRepository;

  PlayerService(this._playerRepository);

  @override
  Future<void> createPlayer(Player player) async {
    try {
      await _playerRepository.addPlayer(player);
    } catch (e) {
      throw Exception('Failed to create player: $e');
    }
  }

  @override
  Future<Player> getPlayerDetails(String playerId) async {
    try {
      return await _playerRepository.getPlayerById(playerId);
    } catch (e) {
      throw Exception('Failed to get player details: $e');
    }
  }

  @override
  Future<List<Player>> getPlayersByTeam(String teamId) async {
    try {
      return await _playerRepository.getPlayersByTeam(teamId);
    } catch (e) {
      throw Exception('Failed to get players by team: $e');
    }
  }

  @override
  Future<void> updatePlayer(Player player) async {
    try {
      await _playerRepository.updatePlayer(player);
    } catch (e) {
      throw Exception('Failed to update player: $e');
    }
  }
}
