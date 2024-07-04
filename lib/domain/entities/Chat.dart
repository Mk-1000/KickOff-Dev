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

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

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
  }

  void removeParticipant(String participantId) {
    participants.remove(participantId);
  }

  void addMessage(Message message) {
    messages.add(message);
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
    try {
      final chatId = json['chatId'] as String;

      final participants = List<String>.from(json['participants'] ?? []);

      final messagesJson = json['messages'] as List?;

      final createdAt = json['createdAt'] as int?;

      final updatedAt = json['updatedAt'] as int?;

      // Convert the messagesJson to a List<Message>
      List<Message> messages = [];
      if (messagesJson != null) {
        messages = messagesJson
            .map((messageJson) =>
                Message.fromJson(Map<String, dynamic>.from(messageJson as Map)))
            .toList();
      }

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
