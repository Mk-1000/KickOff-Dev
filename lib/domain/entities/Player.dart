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

  // Getter for the current player
  static Player? get currentPlayer => _currentPlayer;

  // Method to set the current player
  static void setCurrentPlayer(Player player) {
    _currentPlayer = player;
  }

  String get nickname => _nickname;
  DateTime get birthdate => _birthdate;
  String get preferredPosition => _preferredPosition;
  List<String> get phoneNumbers => _phoneNumbers;
  String get jerseySize => _jerseySize;
  String get playerId => userId;

  // Method to add a team ID to the player's list of team IDs
  void addTeamId(String teamId) {
    _teamIds.add(teamId);
  }

  // Method to remove a team ID from the player's list of team IDs
  void removeTeamId(String teamId) {
    _teamIds.remove(teamId);
  }

  // Method to get the player's list of team IDs
  List<String> get teamIds => _teamIds;

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
      userId: json['userId'],
      email: json['email'],
      nickname: json['nickname'],
      birthdate: DateTime.fromMillisecondsSinceEpoch(json['birthdate']),
      preferredPosition: json['preferredPosition'],
      phoneNumbers: List<String>.from(json['phoneNumbers']),
      jerseySize: json['jerseySize'],
    );
    setCurrentPlayer(
        player); // Optionally set as current player upon creation from JSON
    return player;
  }
}
