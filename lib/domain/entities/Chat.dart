import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/utils/IDUtils.dart';

class Chat {
  late String chatId;
  late Map<String, bool> participants;
  late String lastMessageId;
  late Map<String, dynamic> lastMessageReadReceipts;
  late List<Message> messages;
  late String type;
  late DateTime createdAt;
  late DateTime updatedAt;

  Chat({
    required this.participants,
    required this.lastMessageId,
    required this.lastMessageReadReceipts,
    required this.messages,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  }) {
    // Generate unique chatId using IDUtils if not provided
    chatId = IDUtils.generateUniqueId();
  }

  void _updateTimestamp() {
    updatedAt = DateTime.now();
  }

  void addParticipant(String participantId) {
    participants[participantId] = true;
    lastMessageReadReceipts[participantId] = {'read': false};
    _updateTimestamp();
  }

  void addMessage(Message message) {
    messages.add(message);
    lastMessageId = message.messageId;
    _updateTimestamp();
  }

  void updateType(String newType) {
    type = newType;
    _updateTimestamp();
  }

  void updateLastMessageId(String newLastMessageId) {
    lastMessageId = newLastMessageId;
    _updateTimestamp();
  }

  void updateParticipants(Map<String, bool> newParticipants) {
    participants = newParticipants;
    _updateTimestamp();
  }

  void updateLastMessageReadReceipts(Map<String, dynamic> newReadReceipts) {
    lastMessageReadReceipts = newReadReceipts;
    _updateTimestamp();
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      participants: Map<String, bool>.from(json['participants'] ?? {}),
      lastMessageId: json['lastMessageId'] ?? '',
      lastMessageReadReceipts:
          Map<String, dynamic>.from(json['lastMessageReadReceipts'] ?? {}),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((messageJson) => Message.fromJson(messageJson))
              .toList() ??
          [],
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'participants': participants,
      'lastMessageId': lastMessageId,
      'lastMessageReadReceipts': lastMessageReadReceipts,
      'messages': messages.map((message) => message.toJson()).toList(),
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
