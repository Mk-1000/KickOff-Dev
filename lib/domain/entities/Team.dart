import 'package:takwira/utils/IDUtils.dart';

class Team {
  String _teamId; // Made non-final to allow setting from JSON
  String _teamName;
  String _captainId;
  Map<String, bool> _players;
  String? _chat; // Optional chat
  int _createdAt;
  int _updatedAt;

  Team({
    String? teamId, // Optional teamId that can be passed in
    required String teamName,
    required String captainId,
    required Map<String, bool> players,
    String? chat, // Optional chat
    int? createdAt,
    int? updatedAt,
  })  : _teamId = teamId ??
            IDUtils
                .generateUniqueId(), // Use provided teamId or generate a new one
        _teamName = teamName,
        _captainId = captainId,
        _players = players,
        _chat = chat,
        _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  String get teamId => _teamId;
  String get teamName => _teamName;
  String get captainId => _captainId;
  Map<String, bool> get players => _players;
  String? get chat => _chat;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  set chat(String? value) {
    _chat = value;
  }

  // Method to add a new player
  void addPlayer(String playerId, bool isActive) {
    _players = Map.from(_players); // Ensure the map is mutable
    _players[playerId] = isActive;
    _updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

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
    // Handle potential variations in data structure
    return Team(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String? ?? 'Unknown Team',
      captainId: json['captainId'] as String? ?? 'Unknown Captain',
      players: (json['players'] as Map?)?.map(
            (key, value) => MapEntry(key as String, value as bool),
          ) ??
          {},
      chat: json['chat'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
