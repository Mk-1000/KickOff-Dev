import 'package:takwira/business/services/AuthService.dart';
import 'package:takwira/business/services/PlayerService.dart';
import 'package:takwira/business/services/UserService.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/User.dart';
import 'package:takwira/domain/services/IAuthService.dart';
import 'package:takwira/domain/services/IPlayerService.dart';
import 'package:takwira/domain/services/IUserService.dart';

class PlayerManager {
  final IPlayerService _playerService = PlayerService();
  final IAuthService _authService = AuthService();
  final IUserService _userService = UserService();

  // Method to sign in player with email and password
  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      String userId =
          await _authService.signInWithEmailPassword(email, password);
      Player player = await _playerService.getPlayerDetails(userId);
      Player.setCurrentPlayer(player);
      return userId;
    } catch (e) {
      throw Exception('Failed to sign in player: $e');
    }
  }

  Future<void> signUpPlayer(
      String email, String password, Player player) async {
    try {
      String userId =
          await _authService.signUpWithEmailPassword(email, password);
      User newUser = User(userId: userId, email: email, role: UserRole.Player);
      await _userService.addUser(newUser);

      player.userId = userId;

      await _playerService.createPlayer(player);

      Player.setCurrentPlayer(player);
    } catch (e) {
      throw Exception('Failed to sign up player: $e');
    }
  }

  Future<void> createPlayer(Player player) async {
    try {
      await _playerService.createPlayer(player);
    } catch (e) {
      throw Exception('Failed to create player: $e');
    }
  }

  Future<Player> getPlayerDetails(String playerId) async {
    try {
      return await _playerService.getPlayerDetails(playerId);
    } catch (e) {
      throw Exception('Failed to get player details: $e');
    }
  }

  Future<List<Player>> getPlayersByTeam(String teamId) async {
    try {
      return await _playerService.getPlayersByTeam(teamId);
    } catch (e) {
      throw Exception('Failed to get players by team: $e');
    }
  }

  Future<void> updatePlayer(Player player) async {
    try {
      await _playerService.updatePlayer(player);
    } catch (e) {
      throw Exception('Failed to update player: $e');
    }
  }

  Future<List<Player>> getPlayers() async {
    try {
      return await _playerService!.getAllPlayers();
    } catch (e) {
      throw Exception('Failed to get players: $e');
    }
  }

  Future<void> deletePlayer(String playerId) async {
    try {
      await _playerService.deletePlayer(playerId);
    } catch (e) {
      throw Exception('Failed to delete player: $e');
    }
  }

  Future<void> addSentInvitationToSlot(
      String playerId, String invitationId) async {
    _playerService.addSentInvitationToSlot(playerId, invitationId);
  }

  Future<void> addReceivedInvitationToSlot(
      String playerId, String invitationId) async {
    _playerService.addReceivedInvitationToSlot(playerId, invitationId);
  }

  Future<void> removeSentInvitation(
      String playerId, String invitationId) async {
    _playerService.removeSentInvitation(playerId, invitationId);
  }

  Future<void> removeReceivedInvitation(
      String playerId, String invitationId) async {
    _playerService.removeReceivedInvitation(playerId, invitationId);
  }

  Future<void> addTeamId(String playerId, String teamId) async {
    await _playerService.addTeamId(playerId, teamId);
  }

  Future<void> removeTeamId(String playerId, String teamId) async {
    await _playerService.removeTeamId(playerId, teamId);
  }
}
