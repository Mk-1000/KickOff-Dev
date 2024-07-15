import 'package:takwira/business/services/PlayerService.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/services/IPlayerService.dart';

import '../../domain/entities/Address.dart';

class PlayerManager {
  final IPlayerService _playerService = PlayerService();

  // Method to sign in player with email and password
  Future<String> signInWithEmailPassword(String email, String password) async {
    return await _playerService.signInWithEmailPassword(email, password);
  }

  Future<bool> signUpPlayer(
      String email, String password, Address address, Player player) async {
    try {
      await _playerService.signUpPlayer(email, password, address, player);
      return true;
    } catch (e) {
      return false;
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
      return await _playerService.getAllPlayers();
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
