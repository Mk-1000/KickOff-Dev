import 'package:takwira/domain/entities/User.dart';

class Player extends User {
  static Player? _currentPlayer; // Singleton instance of the current player

  String _nickname;
  DateTime _birthdate;
  String _preferredPosition;
  List<String> _phoneNumbers;
  String _jerseySize;
  List<String> _teamIds = []; // List to store team IDs

  Player({
    String? userId,
    required String email,
    required String nickname,
    required DateTime birthdate,
    required String preferredPosition,
    required List<String> phoneNumbers,
    required String jerseySize,
  })  : _nickname = nickname,
        _birthdate = birthdate,
        _preferredPosition = preferredPosition,
        _phoneNumbers = phoneNumbers,
        _jerseySize = jerseySize,
        super(userId: userId, email: email, role: UserRole.player);

  static Player? get currentPlayer => _currentPlayer;

  static void setCurrentPlayer(Player player) {
    _currentPlayer = player;
  }

  // Use these getters to expose private fields
  String get nickname => _nickname;
  DateTime get birthdate => _birthdate;
  String get preferredPosition => _preferredPosition;
  List<String> get phoneNumbers => _phoneNumbers;
  String get jerseySize => _jerseySize;
  String get playerId => userId;
  List<String> get teamIds => _teamIds;

  void addTeamId(String teamId) {
    if (!_teamIds.contains(teamId)) {
      // Ensure no duplicates
      _teamIds.add(teamId);
    }
  }

  void removeTeamId(String teamId) {
    _teamIds.remove(teamId);
  }

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'nickname': _nickname,
      'birthdate': _birthdate.millisecondsSinceEpoch,
      'preferredPosition': _preferredPosition,
      'phoneNumbers': _phoneNumbers,
      'jerseySize': _jerseySize,
      'teamIds': _teamIds,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    Player player = Player(
      userId: json['userId'] as String?,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birthdate: DateTime.fromMillisecondsSinceEpoch(json['birthdate'] as int),
      preferredPosition: json['preferredPosition'] as String,
      phoneNumbers: json['phoneNumbers'] != null
          ? List<String>.from(json['phoneNumbers'])
          : [],
      jerseySize: json['jerseySize'] as String,
    );
    player._teamIds =
        json['teamIds'] != null ? List<String>.from(json['teamIds']) : [];
    return player;
  }
}
