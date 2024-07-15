import 'package:takwira/business/services/UserService.dart';
import 'package:takwira/infrastructure/repositories/PlayerRepository.dart';
import 'package:takwira/presentation/managers/AddressManager.dart';

import '../../domain/entities/Address.dart';
import '../../domain/entities/Player.dart';
import '../../domain/entities/User.dart';
import '../../domain/repositories/IPlayerRepository.dart';
import '../../domain/services/IPlayerService.dart';
import 'AuthService.dart';

class PlayerService implements IPlayerService {
  final IPlayerRepository _playerRepository;

  PlayerService({IPlayerRepository? playerRepository})
      : _playerRepository = playerRepository ?? PlayerRepository();

  @override
  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      String userId =
          await AuthService().signInWithEmailPassword(email, password);
      Player player = await getPlayerDetails(userId);
      Player.setCurrentPlayer(player);
      return userId;
    } catch (e) {
      throw Exception('Failed to sign in player: $e');
    }
  }

  @override
  Future<void> signUpPlayer(
      String email, String password, Address address, Player player) async {
    try {
      String userId =
          await AuthService().signUpWithEmailPassword(email, password);
      User newUser = User(userId: userId, email: email, role: UserRole.Player);
      await UserService().addUser(newUser);

      player.userId = userId;
      player.addressId = address.addressId;
      address.distinationId = userId;

      await PlayerService().createPlayer(player);
      await AddressManager().createAddress(address);

      Player.setCurrentPlayer(player);
    } catch (e) {
      throw Exception('Failed to sign up player: $e');
    }
  }

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
      player.newUpdate();
      await _playerRepository.updatePlayer(player);
    } catch (e) {
      throw Exception('Failed to update player: $e');
    }
  }

  @override
  Future<List<Player>> getAllPlayers() async {
    try {
      return await _playerRepository.getAllPlayers();
    } catch (e) {
      throw Exception('Failed to retrieve all players: $e');
    }
  }

  @override
  Future<void> deletePlayer(String playerId) async {
    try {
      await _playerRepository.deletePlayer(playerId);
    } catch (e) {
      throw Exception('Failed to delete player: $e');
    }
  }

  @override
  Future<void> addSentInvitationToSlot(
      String playerId, String invitationId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.addSentInvitation(invitationId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to save invitation for Player: $e');
    }
  }

  @override
  Future<void> addReceivedInvitationToSlot(
      String playerId, String invitationId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.addReceivedInvitation(invitationId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to save invitation for Player: $e');
    }
  }

  @override
  Future<void> removeSentInvitation(
      String playerId, String invitationId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.removeSentInvitation(invitationId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to remove invitation from Player: $e');
    }
  }

  @override
  Future<void> removeReceivedInvitation(
      String playerId, String invitationId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.removeReceivedInvitation(invitationId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to remove invitation from Player: $e');
    }
  }

  @override
  Future<void> addTeamId(String playerId, String teamId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.addTeamId(teamId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to add team to Player: $e');
    }
  }

  @override
  Future<void> removeTeamId(String playerId, String teamId) async {
    try {
      Player player = await getPlayerDetails(playerId);
      player.removeTeamId(teamId);
      await updatePlayer(player);
    } catch (e) {
      print('Failed to delete teamId from Player: $e');
    }
  }
}
