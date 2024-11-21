import '../entities/Message.dart';

abstract class IMessageRepository {
  Future<List<Message>> getAllMessages();
  Future<Message> getMessageById(String id);
  Future<void> addMessage(Message message);
  Future<void> updateMessage(Message message);
  Future<void> deleteMessage(String id);
  Future<List<Message>> getMessagesForChat(String chatId);
}
