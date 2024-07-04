import 'package:takwira/utils/IDUtils.dart';

import '../../utils/DateTimeUtils.dart';
import '../../utils/Parse.dart';
import 'Message.dart';

enum ChatType { TeamChat, VsChat }

class Chat {
  final String chatId;
  final List<String> participants;
  final ChatType type;
  final List<Message> messages;
  final int createdAt;
  int updatedAt;

  Chat({
    String? chatId,
    required this.participants,
    required this.type,
    List<Message>? messages,
    int? createdAt,
    int? updatedAt,
  })  : chatId = chatId ?? IDUtils.generateUniqueId(),
        messages = messages ?? [],
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  void addParticipant(String participantId) {
    if (!participants.contains(participantId)) {
      participants.add(participantId);
    }
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  void removeParticipant(String participantId) {
    participants.remove(participantId);
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  void addMessage(Message message) {
    messages.add(message);
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'participants': participants,
      'type': type.toString().split('.').last,
      'messages': messages.map((message) => message.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON:');
    print(json);

    try {
      final chatId = json['chatId'] as String;
      print('chatId: $chatId');

      final participants = List<String>.from(json['participants'] ?? []);
      print('participants: $participants');

      // final typeString = json['type'] as String;
      // final type = ChatType.values.firstWhere(
      //   (e) => e.toString().split('.').last == typeString,
      //   orElse: () => ChatType.public,
      // );
      // print('type: $type');

      final messagesJson = json['messages'] as List?;
      print('messagesJson: $messagesJson');

      final createdAt = json['createdAt'] as int?;
      print('createdAt: $createdAt');

      final updatedAt = json['updatedAt'] as int?;
      print('updatedAt: $updatedAt');

      // Convert the messagesJson to a List<Message>
      List<Message> messages = [];
      if (messagesJson != null) {
        messages = messagesJson
            .map((messageJson) =>
                Message.fromJson(Map<String, dynamic>.from(messageJson as Map)))
            .toList();
      }
      print('messages: $messages');

      return Chat(
        chatId: chatId,
        participants: participants,
        type: json.containsKey('type')
            ? ParserUtils.parseChatType(json['type'] as String)
            : ChatType.TeamChat,
        messages: messages,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e) {
      print('Error during JSON parsing: $e');
      rethrow;
    }
  }
}
