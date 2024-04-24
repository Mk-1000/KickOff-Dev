import '../entities/Chat.dart';
import '../entities/Message.dart';

abstract class IChatService {
  Future<void> sendMessage(Message message);
  Future<List<Message>> getMessagesForChat(String chatId);
  Future<List<Chat>> getAllChatsForUser(String userId);
}
