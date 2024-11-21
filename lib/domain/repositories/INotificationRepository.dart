import '../entities/Notification.dart';

abstract class INotificationRepository {
  Future<List<Notification>> getAllNotifications();
  Future<Notification> getNotificationById(String id);
  Future<void> addNotification(Notification notification);
  Future<void> updateNotification(Notification notification);
  Future<void> deleteNotification(String id);
  Future<List<Notification>> getNotificationsForUser(String userId);
}
