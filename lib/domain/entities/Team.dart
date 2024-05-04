import 'package:takwira/utils/IDUtils.dart';

class Team {
  final String _teamId;
  String _teamName; // Changed to non-final
  String _captainId;
  Map<String, bool> _players; // Changed to non-final
  String _chat;
  final int _createdAt;
  int _updatedAt;

  Team({
    required String teamName,
    required String captainId,
    required Map<String, bool> players,
    required String chat,
    int? createdAt,
    int? updatedAt,
  })  : _teamId = IDUtils.generateUniqueId(),
        _teamName = teamName, // Assigning initial value
        _captainId = captainId,
        _players = Map.unmodifiable(players), // Assigning initial value
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
      teamName: json['teamName'] as String,
      captainId: json['captainId'] as String,
      players: (json['players'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as bool),
      ),
      chat: json['chat'] as String,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
