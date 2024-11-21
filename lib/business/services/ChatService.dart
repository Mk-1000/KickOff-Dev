import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/repositories/IChatRepository.dart';
import 'package:takwira/domain/services/IChatService.dart';
import 'package:takwira/infrastructure/repositories/ChatRepository.dart';

class ChatService implements IChatService {
  final IChatRepository _chatRepository;

  ChatService({IChatRepository? chatRepository})
      : _chatRepository = chatRepository ?? ChatRepository();

  @override
  Future<void> updateChat(Chat chat) async {
    try {
      chat.newUpdate();
      await _chatRepository.updateChat(chat);
    } catch (e) {
      throw Exception('Failed to update player: $e');
    }
  }

  @override
  Future<List<Chat>> getAllChats() async {
    try {
      return await _chatRepository.getAllChats();
    } catch (e) {
      throw Exception('Failed to get all chats: $e');
    }
  }

  @override
  Future<Chat?> getChatById(String chatId) async {
    try {
      Chat? chat = await _chatRepository.getChatById(chatId);
      return chat;
    } catch (e) {
      throw Exception('Faaaaaaailed to get chat by ID: $e');
    }
  }

  @override
  Future<void> createChat(Chat chat) async {
    try {
      await _chatRepository.addChat(chat);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    try {
      await _chatRepository.deleteChat(chatId);
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  @override
  Future<void> addParticipantToChat(String chatId, String participantId) async {
    try {
      Chat? chat = await _chatRepository.getChatById(chatId);
      if (chat == null) {
        throw Exception('Chat not found');
      }
      chat.addParticipant(participantId);
      await updateChat(chat);
    } catch (e) {
      throw Exception('Failed to add participant to chat: $e');
    }
  }

  @override
  Future<void> addMessageToChat(String chatId, Message message) async {
    try {
      Chat? chat = await _chatRepository.getChatById(chatId);
      if (chat == null) {
        throw Exception('Chat not found');
      }
      chat.addMessage(message);
      await updateChat(chat);
    } catch (e) {
      throw Exception('Failed to add message to chat: $e');
    }
  }

  @override
  Stream<List<Message>> getMessagesStream(String chatId) {
    return _chatRepository.getMessagesStream(chatId);
  }
}
