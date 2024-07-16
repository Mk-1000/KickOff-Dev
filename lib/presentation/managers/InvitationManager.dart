// ignore_for_file: empty_catches

import 'package:takwira/business/services/InvitationService.dart';
import 'package:takwira/domain/entities/Invitation.dart';

class InvitationManager {
  final InvitationService _invitationService = InvitationService();

  Future<bool> sendInvitationFromTeamToPlayer({
    required String teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      await _invitationService.sendInvitationFromTeamToPlayer(
        teamId: teamId,
        playerId: playerId,
        slotId: slotId,
      );
      return true;
    } catch (e) {
      print('Failed to send invitation from team to player: $e');
      return false;
    }
  }

  Future<bool> sendInvitationFromPlayerToTeam({
    required String? teamId,
    required String playerId,
    required String slotId,
  }) async {
    try {
      await _invitationService.sendInvitationFromPlayerToTeam(
        teamId: teamId!,
        playerId: playerId,
        slotId: slotId,
      );
      return true;
    } catch (e) {
      print('Failed to send invitation from Player to Team: $e');
      return false;
    }
  }

  Future<bool> sendInvitationFromTeamToTeam({
    required String teamSenderId,
    required String teamReceiverId,
  }) async {
    try {
      await _invitationService.sendInvitationFromTeamToTeam(
        teamSenderId: teamSenderId,
        teamReceiverId: teamReceiverId,
      );
      return true;
    } catch (e) {
      print('Failed to send invitation from Team to Team: $e');
      return false;
    }
  }

  Future<bool> respondToInvitation(String invitationId, bool accept) async {
    try {
      await _invitationService.respondToInvitation(invitationId, accept);
      return true;
    } catch (e) {
      print('Failed to responde to invitation: $e');
      return false;
    }
  }

  Future<bool> removeInvitation(String invitationId) async {
    try {
      await _invitationService.removeInvitation(invitationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Invitation> fetchInvitationDetails(String invitationId) async {
    try {
      return await _invitationService.getInvitationDetails(invitationId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForPlayer(
      String playerId) async {
    try {
      return await _invitationService.fetchSentInvitationsForPlayer(playerId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForPlayer(
      String playerId) async {
    try {
      return await _invitationService
          .fetchReceivedInvitationsForPlayer(playerId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForTeam(
      String teamId) async {
    try {
      return await _invitationService.fetchReceivedInvitationsForTeam(teamId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForTeam(String teamId) async {
    try {
      return await _invitationService.fetchSentInvitationsForTeam(teamId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchReceivedInvitationsForGame(
      String teamId) async {
    try {
      return await _invitationService.fetchReceivedInvitationsForGame(teamId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<List<Invitation>> fetchSentInvitationsForGame(String teamId) async {
    try {
      return await _invitationService.fetchSentInvitationsForGame(teamId);
    } catch (e) {
      throw Exception('Failed to fetch invitation details: $e');
    }
  }

  Future<bool> isInvitationAlreadySent({
    required String playerId,
    required String slotId,
    required InvitationType invitationType,
    String? teamId,
  }) async {
    return _invitationService.isInvitationAlreadySent(
        playerId: playerId,
        slotId: slotId,
        invitationType: invitationType,
        teamId: teamId);
  }

  Future<String> searchInvitationId({
    required String playerId,
    required String slotId,
    required InvitationType invitationType,
    String? teamId,
  }) async {
    return _invitationService.searchInvitationId(
        playerId: playerId,
        slotId: slotId,
        invitationType: invitationType,
        teamId: teamId);
  }
}
