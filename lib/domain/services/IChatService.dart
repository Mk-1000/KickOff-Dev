import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/entities/Chat.dart';

abstract class IChatService {
  Future<List<Chat>> getAllChats();
  Future<Chat?> getChatById(String chatId);
  Future<void> createChat(Chat chat);
  Future<void> updateChat(Chat chat);
  Future<void> deleteChat(String chatId);
  Future<void> addParticipantToChat(String chatId, String participantId);
  Future<void> addMessageToChat(String chatId, Message message);
  Stream<List<Message>> getMessagesStream(String chatId);
}
