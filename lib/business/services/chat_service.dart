import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/repositories/IChatRepository.dart';
import 'package:takwira/domain/services/ichat_service.dart';
import 'package:takwira/infrastructure/repositories/ChatRepository.dart';

class ChatService implements IChatService {
  final IChatRepository _chatRepository;

  ChatService({IChatRepository? chatRepository})
      : _chatRepository = chatRepository ?? ChatRepository();

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
      return await _chatRepository.getChatById(chatId);
    } catch (e) {
      throw Exception('Failed to get chat by ID: $e');
    }
  }

  @override
  Future<void> createChatForTeam(Chat chat) async {
    try {
      await _chatRepository.addChat(chat);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  @override
  Future<void> createChat(
      Chat chat, Message initialMessage, String participantId) async {
    try {
      chat.addParticipant(participantId);
      chat.addMessage(initialMessage);
      await _chatRepository.addChat(chat);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  @override
  Future<void> updateChat(Chat chat) async {
    try {
      await _chatRepository.updateChat(chat);
    } catch (e) {
      throw Exception('Failed to update chat: $e');
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
      final chat = await _chatRepository.getChatById(chatId);
      if (chat == null) {
        throw Exception('Chat not found');
      }
      chat.addParticipant(participantId);
      await _chatRepository.updateChat(chat);
    } catch (e) {
      throw Exception('Failed to add participant to chat: $e');
    }
  }

  @override
  Future<void> addMessageToChat(String chatId, Message message) async {
    try {
      final chat = await _chatRepository.getChatById(chatId);
      if (chat == null) {
        throw Exception('Chat not found');
      }
      chat.addMessage(message);
      await _chatRepository.updateChat(chat);
    } catch (e) {
      throw Exception('Failed to add message to chat: $e');
    }
  }
}
