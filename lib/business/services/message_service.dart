import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Message.dart';
import '../../domain/repositories/IMessageRepository.dart';
import '../../domain/services/imessage_service.dart';

class MessageService implements IMessageService {
  final IMessageRepository _messageRepository;

  MessageService(this._messageRepository);

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
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      await _messageRepository.deleteMessage(messageId);
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }
}
