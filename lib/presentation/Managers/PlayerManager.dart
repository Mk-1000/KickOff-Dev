import 'package:takwira/business/services/player_service.dart';
import 'package:takwira/business/services/user_service.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/User.dart';
import 'package:takwira/domain/services/iplayer_service.dart';
import 'package:takwira/domain/services/iauth_service.dart';
import 'package:takwira/business/services/auth_service.dart';
import 'package:takwira/domain/services/iuser_service.dart';

class PlayerManager {
  final IPlayerService _playerService;
  final IAuthService
      _authService; // AuthenticationService for user authentication
  final IUserService _userService;

  PlayerManager(
      {IPlayerService? playerService,
      IAuthService? authService,
      IUserService? userService})
      : _playerService = playerService ?? PlayerService(),
        _userService = userService ?? UserService(),
        _authService = authService ?? AuthService();

  // Method to sign in player with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      // Sign in the user with email and password
      String userId =
          await _authService.signInWithEmailPassword(email, password);

      // Retrieve player details after successful sign in
      Player player = await _playerService.getPlayerDetails(userId);

      // Set the retrieved player as the current player
      Player.setCurrentPlayer(player);
    } catch (e) {
      throw Exception('Failed to sign in player: $e');
    }
  }

  // Method to sign up player with email and password
  Future<void> signUpPlayer(
      String email, String password, Player player) async {
    try {
      // Create a user with email and password in Firebase Auth
      String userId =
          await _authService.signUpWithEmailPassword(email, password);
      User newUser = User(userId: userId, email: email, role: UserRole.player);
      await _userService.addUser(newUser);

      // Set the userId to the player's Firebase UID
      player.setUserId(userId);

      // Create player record with this userId
      await _playerService.createPlayer(player);

      // Set the current player
      Player.setCurrentPlayer(player);
    } catch (e) {
      throw Exception('Failed to sign up player: $e');
    }
  }

  Future<void> createPlayer(Player player) async {
    if (_playerService != null) {
      try {
        await _playerService!.createPlayer(player);
      } catch (e) {
        throw Exception('Failed to create player: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }

  Future<Player> getPlayerDetails(String playerId) async {
    if (_playerService != null) {
      try {
        return await _playerService!.getPlayerDetails(playerId);
      } catch (e) {
        throw Exception('Failed to get player details: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }

  Future<List<Player>> getPlayersByTeam(String teamId) async {
    if (_playerService != null) {
      try {
        return await _playerService!.getPlayersByTeam(teamId);
      } catch (e) {
        throw Exception('Failed to get players by team: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }

  Future<void> updatePlayer(Player player) async {
    if (_playerService != null) {
      try {
        await _playerService!.updatePlayer(player);
      } catch (e) {
        throw Exception('Failed to update player: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }

  Future<List<Player>> getPlayers() async {
    if (_playerService != null) {
      try {
        return await _playerService!.getAllPlayers();
      } catch (e) {
        throw Exception('Failed to get players: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }

  Future<void> deletePlayer(String playerId) async {
    if (_playerService != null) {
      try {
        await _playerService!.deletePlayer(playerId);
      } catch (e) {
        throw Exception('Failed to delete player: $e');
      }
    } else {
      throw Exception('Player service not initialized');
    }
  }
}
