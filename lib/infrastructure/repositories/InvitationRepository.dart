import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Invitation.dart';
import '../../domain/repositories/IInvitationRepository.dart';
import '../firebase/FirebaseService.dart';

class InvitationRepository implements IInvitationRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'invitations';

  InvitationRepository(this._firebaseService);

  // @override
  // Future<List<Invitation>> getAllInvitations() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> invitations =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return invitations.values
  //         .map((e) => Invitation.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Invitation>> getAllInvitations() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final invitations = <Invitation>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          invitations
              .add(Invitation.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return invitations; // Return the initially loaded invitations
  }

  @override
  Future<Invitation> getInvitationById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Invitation.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Invitation not found');
  }

  @override
  Future<void> addInvitation(Invitation invitation) async {
    await _firebaseService.setDocument(_collectionPath, invitation.toJson());
  }

  @override
  Future<void> updateInvitation(Invitation invitation) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${invitation.invitationId}', invitation.toJson());
  }

  @override
  Future<void> deleteInvitation(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Invitation>> getInvitationsByUser(String userId) async {
    final query =
        _firebaseService.getCollectionStream(_collectionPath).map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .where(
              (value) => (value as Map<dynamic, dynamic>)['userId'] == userId)
          .map((value) => Invitation.fromJson(
              Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
          .toList();
    });

    // Since streams are async and continuous, we need to await the first matching element
    final List<Invitation> invitations = await query.first;
    return invitations;
  }
}
