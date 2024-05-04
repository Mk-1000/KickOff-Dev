class Match {
  String _matchId;
  String _homeTeam;
  String _awayTeam;
  DateTime _matchDate;
  String _stadium;
  String _chat;
  bool _visibility;
  String _status;
  DateTime _createdAt;
  DateTime _updatedAt;

  Match({
    required String matchId,
    required String homeTeam,
    required String awayTeam,
    required DateTime matchDate,
    required String stadium,
    required String chat,
    required bool visibility,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _matchId = matchId,
        _homeTeam = homeTeam,
        _awayTeam = awayTeam,
        _matchDate = matchDate,
        _stadium = stadium,
        _chat = chat,
        _visibility = visibility,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get matchId => _matchId;
  String get homeTeam => _homeTeam;
  String get awayTeam => _awayTeam;
  DateTime get matchDate => _matchDate;
  String get stadium => _stadium;
  String get chat => _chat;
  bool get visibility => _visibility;
  String get status => _status;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'matchId': _matchId,
      'homeTeam': _homeTeam,
      'awayTeam': _awayTeam,
      'matchDate': _matchDate.toIso8601String(),
      'stadium': _stadium,
      'chat': _chat,
      'visibility': _visibility,
      'status': _status,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchId: json['matchId'] as String,
      homeTeam: json['homeTeam'] as String,
      awayTeam: json['awayTeam'] as String,
      matchDate: DateTime.parse(json['matchDate'] as String),
      stadium: json['stadium'] as String,
      chat: json['chat'] as String,
      visibility: json['visibility'] as bool,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
