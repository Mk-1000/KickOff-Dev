import '../../domain/entities/Notification.dart';
import '../../domain/repositories/INotificationRepository.dart';
import '../../domain/services/INotificationService.dart';

class NotificationService implements INotificationService {
  final INotificationRepository _notificationRepository;

  NotificationService(this._notificationRepository);

  @override
  Future<List<Notification>> getNotificationsForUser(String userId) async {
    try {
      return await _notificationRepository.getNotificationsForUser(userId);
    } catch (e) {
      throw Exception('Failed to get notifications for user: $e');
    }
  }

  @override
  Future<void> sendNotification(Notification notification) async {
    try {
      await _notificationRepository.addNotification(notification);
    } catch (e) {
      throw Exception('Failed to send notification: $e');
    }
  }

  @override
  Future<void> showLocalNotification(String title, String body) {
    // TODO: implement showLocalNotification
    throw UnimplementedError();
  }
}
