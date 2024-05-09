import 'package:takwira/utils/IDUtils.dart';

class Team {
  String _teamId; // Made non-final to allow setting from JSON
  String _teamName;
  String _captainId;
  Map<String, bool> _players;
  String _chat;
  int _createdAt;
  int _updatedAt;

  Team({
    String? teamId, // Optional teamId that can be passed in
    required String teamName,
    required String captainId,
    required Map<String, bool> players,
    required String chat,
    int? createdAt,
    int? updatedAt,
  })  : _teamId = teamId ??
            IDUtils
                .generateUniqueId(), // Use provided teamId or generate a new one
        _teamName = teamName,
        _captainId = captainId,
        _players = Map.unmodifiable(players),
        _chat = chat,
        _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  String get teamId => _teamId;
  String get teamName => _teamName;
  String get captainId => _captainId;
  Map<String, bool> get players => _players;
  String get chat => _chat;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'teamId': _teamId,
      'teamName': _teamName,
      'captainId': _captainId,
      'players': _players,
      'chat': _chat,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'], // Accepts teamId from JSON
      teamName: json['teamName'] ?? 'Unknown Team',
      captainId: json['captainId'] ?? 'Unknown Captain',
      players: json['players'] != null
          ? (json['players'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value as bool),
            )
          : {},
      chat: json['chat'] ?? '',
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
