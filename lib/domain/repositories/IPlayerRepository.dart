import '../entities/Player.dart';

abstract class IPlayerRepository {
  Future<List<Player>> getAllPlayers();
  Future<Player> getPlayerById(String id);
  Future<void> addPlayer(Player player);
  Future<void> updatePlayer(Player player);
  Future<void> deletePlayer(String id);
  Future<List<Player>> getPlayersByTeam(String teamId);
}
