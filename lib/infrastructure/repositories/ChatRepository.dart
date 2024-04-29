import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Chat.dart';
import '../../domain/repositories/IChatRepository.dart';
import '../firebase/FirebaseService.dart';

class ChatRepository implements IChatRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'chats';

  ChatRepository(this._firebaseService);

  // @override
  // Future<List<Chat>> getAllChats() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> chatsMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return chatsMap.values
  //         .map((e) => Chat.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Chat>> getAllChats() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final chats = <Chat>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          chats.add(Chat.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return chats; // Return the initially loaded chats
  }

  @override
  Future<Chat> getChatById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Chat.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Chat not found');
  }

  @override
  Future<void> addChat(Chat chat) async {
    await _firebaseService.setDocument(_collectionPath, chat.toJson());
  }

  @override
  Future<void> updateChat(Chat chat) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${chat.chatId}', chat.toJson());
  }

  @override
  Future<void> deleteChat(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Chat>> getAllChatsForUser(String userId) {
    // TODO: implement getAllChatsForUser
    throw UnimplementedError();
  }

  // @override
  // Future<List<Chat>> getAllChatsForUser(String userId) async {
  //   var chatsSnapshot = await _firebaseService
  //       .getDatabaseReference('chats')
  //       .orderByChild('participants/$userId')
  //       .equalTo(true)
  //       .get();

  //   if (chatsSnapshot.exists && chatsSnapshot.value != null) {
  //     return Map<String, dynamic>.from(chatsSnapshot.value as Map)
  //         .values
  //         .map((chatData) => Chat.fromJson(Map<String, dynamic>.from(chatData)))
  //         .toList();
  //   }
  //   return [];
  // }
}
