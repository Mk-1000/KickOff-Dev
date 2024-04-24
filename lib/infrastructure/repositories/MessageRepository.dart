import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Message.dart';
import '../../domain/repositories/IMessageRepository.dart';
import '../firebase/FirebaseService.dart';

class MessageRepository implements IMessageRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'messages';

  MessageRepository(this._firebaseService);

  // @override
  // Future<List<Message>> getAllMessages() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> messagesMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return messagesMap.values
  //         .map((e) => Message.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Message>> getAllMessages() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final messages = <Message>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          messages.add(Message.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return messages; // Return the initially loaded messages
  }

  @override
  Future<Message> getMessageById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Message.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Message not found');
  }

  @override
  Future<void> addMessage(Message message) async {
    await _firebaseService.addDocument(_collectionPath, message.toJson());
  }

  @override
  Future<void> updateMessage(Message message) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${message.messageId}', message.toJson());
  }

  @override
  Future<void> deleteMessage(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Message>> getMessagesForChat(String chatId) async {
    final query =
        _firebaseService.getCollectionStream(_collectionPath).map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .where(
              (value) => (value as Map<dynamic, dynamic>)['chatId'] == chatId)
          .map((value) => Message.fromJson(
              Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
          .toList();
    });

    // Since streams are async and continuous, we need to await the first matching element
    final List<Message> messages = await query.first;
    return messages;
  }
}
