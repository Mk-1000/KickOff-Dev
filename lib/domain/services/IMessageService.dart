import '../entities/Message.dart';

abstract class IMessageService {
  Future<void> sendMessage(Message message);
  Future<List<Message>> getMessagesForChat(String chatId);
  Future<void> deleteMessage(String messageId);
}
