class Chat {
  String _chatId;
  Map<String, bool> _participants;
  Map<String, dynamic> _lastMessage;
  Map<String, dynamic> _readReceipts;

  Chat({
    required String chatId,
    required Map<String, bool> participants,
    required Map<String, dynamic> lastMessage,
    required Map<String, dynamic> readReceipts,
  })  : _chatId = chatId,
        _participants = participants,
        _lastMessage = lastMessage,
        _readReceipts = readReceipts;

  String get chatId => _chatId;
  Map<String, bool> get participants => Map<String, bool>.from(_participants);
  Map<String, dynamic> get lastMessage =>
      Map<String, dynamic>.from(_lastMessage);
  Map<String, dynamic> get readReceipts =>
      Map<String, dynamic>.from(_readReceipts);

  Map<String, dynamic> toJson() {
    return {
      'chatId': _chatId,
      'participants': _participants,
      'lastMessage': _lastMessage,
      'readReceipts': _readReceipts,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'] as String,
      participants: (json['participants'] as Map<dynamic, dynamic>)
          .map((key, value) => MapEntry(key as String, value as bool)),
      lastMessage: Map<String, dynamic>.from(json['lastMessage'] as Map),
      readReceipts: Map<String, dynamic>.from(json['readReceipts'] as Map),
    );
  }
}
