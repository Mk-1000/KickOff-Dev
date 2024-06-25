import 'package:takwira/domain/entities/Message.dart';

import '../entities/Chat.dart';

abstract class IChatRepository {
  Future<List<Chat>> getAllChats();
  Future<Chat?> getChatById(String id);
  Future<void> addChat(Chat chat);
  Future<void> updateChat(Chat chat);
  Future<void> deleteChat(String id);
  Future<List<Chat>> getAllChatsForUser(String userId);
  Stream<List<Message>> getMessagesStream(String chatId);
}
