import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Chat.dart';
import '../../domain/repositories/IChatRepository.dart';
import '../firebase/FirebaseService.dart';

class ChatRepository implements IChatRepository {
  final String _collectionPath = 'chats';
  final FirebaseService _firebaseService;

  ChatRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<List<Chat>> getAllChats() async {
    try {
      final Stream<DatabaseEvent> stream =
          _firebaseService.getCollectionStream(_collectionPath);
      final List<Chat> chats = [];

      await for (DatabaseEvent event in stream) {
        if (event.snapshot.exists) {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            chats.add(Chat.fromJson(Map<String, dynamic>.from(value)));
          });
        }
      }

      return chats;
    } catch (e) {
      print('Failed to retrieve all chats: $e');
      throw Exception('Failed to retrieve all chats');
    }
  }

  @override
  Future<Chat?> getChatById(String id) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');
      if (snapshot.exists && snapshot.value != null) {
        var chatData = snapshot.value as Map;
        return Chat.fromJson(Map<String, dynamic>.from(chatData));
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching chat by ID $id: $e');
      throw Exception('Error fetching chat by ID $id: $e');
    }
  }

  @override
  Future<void> addChat(Chat chat) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${chat.chatId}', chat.toJson());
      print('Chat added successfully: ${chat.chatId}');
    } catch (e) {
      print('Failed to add chat: $e');
      throw Exception('Failed to add chat: $e');
    }
  }

  @override
  Future<void> updateChat(Chat chat) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${chat.chatId}', chat.toJson());
      print('Chat updated successfully: ${chat.chatId}');
    } catch (e) {
      print('Failed to update chat: $e');
      throw Exception('Failed to update chat: $e');
    }
  }

  @override
  Future<void> deleteChat(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
      print('Chat deleted successfully: $id');
    } catch (e) {
      print('Failed to delete chat: $e');
      throw Exception('Failed to delete chat: $e');
    }
  }

  @override
  Future<List<Chat>> getAllChatsForUser(String userId) async {
    try {
      // Implement logic to retrieve chats for a specific user
      return [];
    } catch (e) {
      print('Failed to retrieve chats for user $userId: $e');
      throw Exception('Failed to retrieve chats for user $userId');
    }
  }
}
