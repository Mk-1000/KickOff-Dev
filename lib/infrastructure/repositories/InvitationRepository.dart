import 'package:firebase_database/firebase_database.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/repositories/IInvitationRepository.dart';
import 'package:takwira/infrastructure/firebase/FirebaseService.dart';

class InvitationRepository implements IInvitationRepository {
  final String _collectionPath = 'invitations';
  final FirebaseService _firebaseService;

  InvitationRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addInvitation(Invitation invitation) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${invitation.invitationId}', invitation.toJson());
    } catch (e) {
      throw Exception('Failed to add invitation: $e');
    }
  }

  @override
  Future<Invitation> getInvitationById(String invitationId) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$invitationId');
      if (snapshot.exists && snapshot.value != null) {
        var invitationData = snapshot.value as Map;
        return Invitation.fromJson(Map<String, dynamic>.from(invitationData));
      } else {
        throw Exception('Invitation not found for ID $invitationId');
      }
    } catch (e) {
      throw Exception('Error fetching invitation by ID $invitationId: $e');
    }
  }

  @override
  Future<List<Invitation>> getInvitationsByPlayerId(String playerId) async {
    try {
      final query =
          _firebaseService.getCollectionStream(_collectionPath).map((event) {
        return (event.snapshot.value as Map<dynamic, dynamic>)
            .values
            .where((value) =>
                (value as Map<dynamic, dynamic>)['playerId'] == playerId)
            .map((value) => Invitation.fromJson(
                Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
            .toList();
      });
      final List<Invitation> invitations = await query.first;
      return invitations;
    } catch (e) {
      throw Exception('Failed to retrieve invitations by player $playerId');
    }
  }

  @override
  Future<List<Invitation>> getInvitationsByTeamId(String teamId) async {
    try {
      final query =
          _firebaseService.getCollectionStream(_collectionPath).map((event) {
        return (event.snapshot.value as Map<dynamic, dynamic>)
            .values
            .where(
                (value) => (value as Map<dynamic, dynamic>)['teamId'] == teamId)
            .map((value) => Invitation.fromJson(
                Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
            .toList();
      });
      final List<Invitation> invitations = await query.first;
      return invitations;
    } catch (e) {
      throw Exception('Failed to retrieve invitations by team $teamId');
    }
  }

  @override
  Future<void> updateInvitation(Invitation invitation) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${invitation.invitationId}', invitation.toJson());
    } catch (e) {
      throw Exception('Failed to update invitation: $e');
    }
  }

  @override
  Future<void> deleteInvitation(String invitationId) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$invitationId');
    } catch (e) {
      throw Exception('Failed to delete invitation: $e');
    }
  }
}
