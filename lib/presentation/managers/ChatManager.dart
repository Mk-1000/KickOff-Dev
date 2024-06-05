import 'package:takwira/business/services/chat_service.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/services/ichat_service.dart';

class ChatManager {
  final IChatService _chatService = ChatService();

  Future<Chat?> getChatDetails(String chatId) async {
    try {
      Chat? chat = await _chatService.getChatById(chatId);
      return chat;
    } catch (e) {
      throw Exception('Failed to load chat details: $e');
    }
  }

  Future<void> createNewChat(
      Chat chat, Message initialMessage, String participantId) async {
    try {
      await _chatService.createChat(chat, initialMessage, participantId);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  Future<void> addNewPlayerToChat(String chatId, String playerId) async {
    try {
      await _chatService.addParticipantToChat(chatId, playerId);
    } catch (e) {
      throw Exception('Failed to add player to chat: $e');
    }
  }

  Future<void> addNewMessageToChat(String chatId, Message message) async {
    try {
      await _chatService.addMessageToChat(chatId, message);
    } catch (e) {
      throw Exception('Failed to add message to chat: $e');
    }
  }

  Future<void> updateChatDetails(String chatId, Chat updatedChat) async {
    try {
      await _chatService.updateChat(updatedChat);
    } catch (e) {
      throw Exception('Failed to update chat details: $e');
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _chatService.deleteChat(chatId);
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  Future<List<Message>> loadChatMessages(String chatId) async {
    try {
      Chat? chat = await _chatService.getChatById(chatId);
      if (chat != null) {
        return chat.messages;
      } else {
        throw Exception('Chat not found');
      }
    } catch (e) {
      throw Exception('Failed to load chat messages: $e');
    }
  }

  Future<List<String>> loadChatParticipants(String chatId) async {
    try {
      Chat? chat = await _chatService.getChatById(chatId);
      if (chat != null) {
        return chat.participants;
      } else {
        throw Exception('Chat not found');
      }
    } catch (e) {
      throw Exception('Failed to load chat participants: $e');
    }
  }
}
