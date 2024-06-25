import 'package:firebase_database/firebase_database.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/infrastructure/firebase/FirebaseService.dart';
import 'package:takwira/domain/repositories/IChatRepository.dart';

class ChatRepository implements IChatRepository {
  final String _collectionPath = 'chats';
  final FirebaseService _firebaseService;

  ChatRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addChat(Chat chat) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${chat.chatId}', chat.toJson());
    } catch (e) {
      throw Exception('Failed to add chat: $e');
    }
  }

  @override
  Future<Chat?> getChatById(String id) async {
    try {
      print('Fetching chat by ID: $id');
      final DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');
      if (snapshot.exists && snapshot.value != null) {
        print('Chat document found for ID: $id');
        final dynamic chatData = snapshot.value;
        print('Raw chat data: $chatData');
        if (chatData is Map<dynamic, dynamic>) {
          final chatDataMap = Map<String, dynamic>.from(chatData);
          print('Chat data map: $chatDataMap');
          return Chat.fromJson(chatDataMap);
        } else {
          print('Chat data is not in the expected format');
          return null;
        }
      } else {
        print('Chat document does not exist for ID: $id');
        return null;
      }
    } catch (e) {
      print('Error fetching chat by ID $id: $e');
      throw Exception('Error fetching chat by ID $id: $e');
    }
  }

  @override
  Future<void> updateChat(Chat chat) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${chat.chatId}', chat.toJson());
    } catch (e) {
      throw Exception('Failed to update chat: $e');
    }
  }

  @override
  Future<void> deleteChat(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  @override
  Future<List<Chat>> getAllChats() async {
    try {
      final DatabaseReference ref =
          _firebaseService.getCollectionReference(_collectionPath);
      final DatabaseEvent event = await ref.once();
      final DataSnapshot snapshot = event.snapshot;
      final List<Chat> chats = [];

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          chats.add(Chat.fromJson(Map<String, dynamic>.from(value)));
        });
      }

      return chats;
    } catch (e) {
      throw Exception('Failed to retrieve all chats: $e');
    }
  }

  @override
  Future<List<Chat>> getAllChatsForUser(String userId) async {
    try {
      final DatabaseReference ref =
          _firebaseService.getCollectionReference(_collectionPath);
      final DatabaseEvent event =
          await ref.orderByChild('participants/$userId').equalTo(true).once();
      final DataSnapshot snapshot = event.snapshot;
      final List<Chat> chats = [];

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          chats.add(Chat.fromJson(Map<String, dynamic>.from(value)));
        });
      }

      return chats;
    } catch (e) {
      throw Exception('Failed to retrieve chats for user $userId: $e');
    }
  }

  Stream<List<Chat>> getChatsStream() {
    final DatabaseReference ref =
        _firebaseService.getCollectionReference(_collectionPath);
    return ref.onValue.map((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        return data.values
            .map((value) => Chat.fromJson(Map<String, dynamic>.from(value)))
            .toList();
      }
      return [];
    });
  }

  @override
  Stream<List<Message>> getMessagesStream(String chatId) {
    final DatabaseReference ref = _firebaseService
        .getCollectionReference('$_collectionPath/$chatId/messages');
    return ref.onValue.map((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as List<dynamic>;
        return data
            .map((value) => Message.fromJson(Map<String, dynamic>.from(value)))
            .toList();
      }
      return [];
    });
  }
}
