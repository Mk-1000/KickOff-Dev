import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/entities/Notification.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/repositories/IChatRepository.dart';
import 'package:takwira/domain/repositories/IMessageRepository.dart';
import 'package:takwira/domain/repositories/IPlayerRepository.dart';
import 'package:takwira/domain/repositories/INotificationRepository.dart'; // Make sure this is correctly imported
import 'package:takwira/domain/services/ichat_service.dart';
import 'package:takwira/domain/services/inotification_service.dart';

class ChatService implements IChatService {
  final IChatRepository _chatRepository;
  final IMessageRepository _messageRepository;
  final INotificationService _notificationService;
  final IPlayerRepository _playerRepository;
  final INotificationRepository
      _notificationRepository; // Assuming you have this for database interactions

  ChatService(
      this._chatRepository,
      this._messageRepository,
      this._notificationService,
      this._playerRepository,
      this._notificationRepository);

  @override
  Future<List<Chat>> getAllChatsForUser(String userId) async {
    try {
      return await _chatRepository.getAllChatsForUser(userId);
    } catch (e) {
      throw Exception('Failed to get chats for user: $e');
    }
  }

  @override
  Future<List<Message>> getMessagesForChat(String chatId) async {
    try {
      return await _messageRepository.getMessagesForChat(chatId);
    } catch (e) {
      throw Exception('Failed to get messages for chat: $e');
    }
  }

  @override
  Future<void> sendMessage(Message message) async {
    try {
      await _messageRepository.addMessage(message);
      // Optionally notify players in the chat
      // notifyTeamPlayers(teamId); // Uncomment and use the correct teamId if necessary
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> notifyTeamPlayers(String teamId) async {
    List<Player> players = await _playerRepository.getPlayersByTeam(teamId);
    String notificationTitle = "New Message";
    String notificationMessage = "You have a new message in your team chat!";

    // Directly show notifications locally, assuming each client handles their own
    try {
      // This assumes _notificationService is set up to handle local notifications
      await _notificationService.showLocalNotification(
          notificationTitle, notificationMessage);
      print('Local notification scheduled to show.');
    } catch (e) {
      print('Failed to schedule local notification: $e');
    }
  }
}
