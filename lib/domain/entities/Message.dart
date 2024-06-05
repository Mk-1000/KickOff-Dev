import 'package:takwira/utils/IDUtils.dart';

class Message {
  String _messageId;
  String _content;
  int _sendDate;
  String _senderId;

  Message({
    String? messageId,
    required String content,
    required String senderId,
    int? sendDate,
  })  : _messageId = messageId ?? IDUtils.generateUniqueId(),
        _content = content,
        _sendDate = sendDate ?? DateTime.now().millisecondsSinceEpoch,
        _senderId = senderId;

  String get messageId => _messageId;
  String get content => _content;
  int get sendDate => _sendDate;
  String get senderId => _senderId;

  Map<String, dynamic> toJson() {
    return {
      'messageId': _messageId,
      'content': _content,
      'sendDate': _sendDate,
      'senderId': _senderId,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'],
      content: json['content'] ?? '',
      sendDate: json['sendDate'] as int?,
      senderId: json['senderId'] ?? '',
    );
  }
}
