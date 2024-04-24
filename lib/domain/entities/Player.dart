class Player {
  final String _playerId;
  final String _nickname;
  final DateTime _birthdate;
  final String _preferredPosition;
  final List<String> _phoneNumbers;
  final String _jerseySize;
  final Map<String, bool> _teams;
  final DateTime _createdAt;
  final DateTime _updatedAt;
  final String _deviceToken; // New field for storing the device token

  Player({
    required String playerId,
    required String nickname,
    required DateTime birthdate,
    required String preferredPosition,
    required List<String> phoneNumbers,
    required String jerseySize,
    required Map<String, bool> teams,
    required DateTime createdAt,
    required DateTime updatedAt,
    String deviceToken = '', // Default empty string for device token
  })  : _playerId = playerId,
        _nickname = nickname,
        _birthdate = birthdate,
        _preferredPosition = preferredPosition,
        _phoneNumbers = phoneNumbers,
        _jerseySize = jerseySize,
        _teams = teams,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _deviceToken = deviceToken;

  // Getters for all fields including the new deviceToken
  String get playerId => _playerId;
  String get nickname => _nickname;
  DateTime get birthdate => _birthdate;
  String get preferredPosition => _preferredPosition;
  List<String> get phoneNumbers => _phoneNumbers;
  String get jerseySize => _jerseySize;
  Map<String, bool> get teams => _teams;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  String get deviceToken => _deviceToken;

  // Method to convert the player object to JSON, including the device token
  Map<String, dynamic> toJson() {
    return {
      'playerId': _playerId,
      'nickname': _nickname,
      'birthdate': _birthdate.toIso8601String(),
      'preferredPosition': _preferredPosition,
      'phoneNumbers': _phoneNumbers,
      'jerseySize': _jerseySize,
      'teams': _teams,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
      'deviceToken': _deviceToken, // Include the deviceToken in the JSON output
    };
  }

  // Factory constructor to create a player from a JSON object, including the device token
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json['playerId'] as String,
      nickname: json['nickname'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      preferredPosition: json['preferredPosition'] as String,
      phoneNumbers: List<String>.from(json['phoneNumbers'] as List),
      jerseySize: json['jerseySize'] as String,
      teams: (json['teams'] as Map).map(
        (key, value) => MapEntry(key as String, value as bool),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deviceToken:
          json['deviceToken'] as String, // Parse the deviceToken from JSON
    );
  }
}
