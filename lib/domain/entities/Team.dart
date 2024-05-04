class Team {
  final String _teamId;
  String _teamName; // Changed to non-final
  final String _captain;
  Map<String, bool> _players; // Changed to non-final
  final String _chat;
  final int _createdAt;
  int _updatedAt;

  Team({
    required String teamId,
    required String teamName,
    required String captain,
    required Map<String, bool> players,
    required String chat,
    int? createdAt,
    int? updatedAt,
  })  : _teamId = teamId,
        _teamName = teamName, // Assigning initial value
        _captain = captain,
        _players = Map.unmodifiable(players), // Assigning initial value
        _chat = chat,
        _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  String get teamId => _teamId;
  String get teamName => _teamName;
  String get captain => _captain;
  Map<String, bool> get players => _players;
  String get chat => _chat;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  void setTeamName(String teamName) {
    _teamName = teamName;
  }

  void setPlayers(Map<String, bool> players) {
    _players = Map.unmodifiable(players);
  }

  void setUpdatedAt(int updatedAt) {
    _updatedAt = updatedAt;
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': _teamId,
      'teamName': _teamName,
      'captain': _captain,
      'players': _players,
      'chat': _chat,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      captain: json['captain'] as String,
      players: (json['players'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as bool),
      ),
      chat: json['chat'] as String,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    )..setUpdatedAt(json['updatedAt'] as int);
  }
}
