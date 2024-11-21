import '../entities/Address.dart';
import '../entities/Player.dart';

abstract class IPlayerService {
  Future<void> createPlayer(Player player);

  Future<Player> getPlayerDetails(String playerId);

  Future<void> updatePlayer(Player player);

  Future<List<Player>> getPlayersByTeam(String teamId);

  Future<List<Player>> getAllPlayers();

  Future<void> deletePlayer(String playerId);

  Future<void> addSentInvitationToSlot(String playerId, String invitationId);

  Future<void> addReceivedInvitationToSlot(
      String playerId, String invitationId);

  Future<void> removeSentInvitation(String playerId, String invitationId);

  Future<void> removeReceivedInvitation(String playerId, String invitationId);

  Future<void> addTeamId(String playerId, String teamId);

  Future<void> removeTeamId(String playerId, String teamId);
  Future<String> signInWithEmailPassword(String email, String password);

  Future<void> signUpPlayer(
      String email, String password, Address address, Player player);
}
