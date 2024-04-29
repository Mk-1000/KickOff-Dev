import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Notification.dart';
import '../../domain/repositories/INotificationRepository.dart';
import '../firebase/FirebaseService.dart';

class NotificationRepository implements INotificationRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'notifications';

  NotificationRepository(this._firebaseService);

  // @override
  // Future<List<Notification>> getAllNotifications() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> notificationsMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return notificationsMap.values
  //         .map(
  //             (e) => Notification.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Notification>> getAllNotifications() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final notifications = <Notification>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          notifications
              .add(Notification.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return notifications; // Return the initially loaded notifications
  }

  @override
  Future<Notification> getNotificationById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Notification.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Notification not found');
  }

  @override
  Future<void> addNotification(Notification notification) async {
    await _firebaseService.setDocument(_collectionPath, notification.toJson());
  }

  @override
  Future<void> updateNotification(Notification notification) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${notification.id}', notification.toJson());
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Notification>> getNotificationsForUser(String userId) async {
    final query =
        _firebaseService.getCollectionStream(_collectionPath).map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .where(
              (value) => (value as Map<dynamic, dynamic>)['userId'] == userId)
          .map((value) => Notification.fromJson(
              Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
          .toList();
    });

    // Since streams are async and continuous, we need to await the first matching element
    final List<Notification> notifications = await query.first;
    return notifications;
  }
}
