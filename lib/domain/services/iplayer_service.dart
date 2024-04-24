import '../entities/Player.dart';

abstract class IPlayerService {
  Future<void> createPlayer(Player player);
  Future<Player> getPlayerDetails(String playerId);
  Future<void> updatePlayer(Player player);
  Future<List<Player>> getPlayersByTeam(String teamId);
}
