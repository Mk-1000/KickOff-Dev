import '../entities/Notification.dart';

abstract class INotificationService {
  Future<void> sendNotification(Notification notification);
  Future<List<Notification>> getNotificationsForUser(String userId);
  Future<void> showLocalNotification(String title, String body);
}
