import 'package:takwira/utils/IDUtils.dart';

class Message {
  final String messageId;
  final String content;
  final int sendAt;
  final String senderId;

  Message({
    String? messageId,
    required this.content,
    required this.senderId,
    int? sendAt,
  })  : messageId = messageId ?? IDUtils.generateUniqueId(),
        sendAt = sendAt ?? DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'content': content,
      'sendAt': sendAt,
      'senderId': senderId,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'] as String,
      content: json['content'] as String? ?? '',
      sendAt: json['sendAt'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      senderId: json['senderId'] as String? ?? '',
    );
  }
}
