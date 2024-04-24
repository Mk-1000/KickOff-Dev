class Team {
  final String _teamId;
  final String _teamName;
  final String _captain;
  final Map<String, bool> _players;
  final String _chat;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  Team({
    required String teamId,
    required String teamName,
    required String captain,
    required Map<String, bool> players,
    required String chat,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _teamId = teamId,
        _teamName = teamName,
        _captain = captain,
        _players = players,
        _chat = chat,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get teamId => _teamId;
  String get teamName => _teamName;
  String get captain => _captain;
  Map<String, bool> get players => _players;
  String get chat => _chat;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'teamId': _teamId,
      'teamName': _teamName,
      'captain': _captain,
      'players': _players,
      'chat': _chat,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      captain: json['captain'] as String,
      players: (json['players'] as Map<dynamic, dynamic>).map(
        (key, value) => MapEntry(key as String, value as bool),
      ),
      chat: json['chat'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
