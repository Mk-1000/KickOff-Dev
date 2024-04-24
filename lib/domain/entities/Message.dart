class Message {
  final String _messageId;
  final String _content;
  final DateTime _sendDate;
  final String _senderId;
  final String _chatId;

  Message({
    required String messageId,
    required String content,
    required DateTime sendDate,
    required String senderId,
    required String chatId,
  })  : _messageId = messageId,
        _content = content,
        _sendDate = sendDate,
        _senderId = senderId,
        _chatId = chatId;

  String get messageId => _messageId;
  String get content => _content;
  DateTime get sendDate => _sendDate;
  String get senderId => _senderId;
  String get chatId => _chatId;

  Map<String, dynamic> toJson() {
    return {
      'messageId': _messageId,
      'content': _content,
      'sendDate': _sendDate.toIso8601String(),
      'senderId': _senderId,
      'chatId': _chatId,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'] as String,
      content: json['content'] as String,
      sendDate: DateTime.parse(json['sendDate'] as String),
      senderId: json['senderId'] as String,
      chatId: json['chatId'] as String,
    );
  }
}
