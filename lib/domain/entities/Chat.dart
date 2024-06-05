import 'package:takwira/utils/IDUtils.dart';
import 'Message.dart';

enum ChatType { private, public }

class Chat {
  String _chatId;
  List<String> _participants;
  ChatType _type;
  List<Message> _messages;
  int _createdAt;
  int _updatedAt;

  Chat({
    String? chatId,
    required List<String> participants,
    required ChatType type,
    List<Message>? messages,
    int? createdAt,
    int? updatedAt,
  })  : _chatId = chatId ?? IDUtils.generateUniqueId(),
        _participants = participants,
        _type = type,
        _messages = messages ?? [],
        _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  String get chatId => _chatId;
  List<String> get participants => _participants;
  ChatType get type => _type;
  List<Message> get messages => _messages;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  void addParticipant(String participantId) {
    if (!_participants.contains(participantId)) {
      _participants.add(participantId);
    }
  }

  void addMessage(Message message) {
    _messages.add(message);
    _updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': _chatId,
      'participants': _participants,
      'type': _type.toString().split('.').last,
      'messages': _messages.map((message) => message.toJson()).toList(),
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'],
      participants: List<String>.from(json['participants'] ?? []),
      type: json['type'] == 'private' ? ChatType.private : ChatType.public,
      messages: json['messages'] != null
          ? (json['messages'] as List<dynamic>)
              .map((messageJson) => Message.fromJson(messageJson))
              .toList()
          : [],
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
