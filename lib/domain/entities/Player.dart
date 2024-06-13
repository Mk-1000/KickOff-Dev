import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/User.dart';

class Player extends User {
  static Player? _currentPlayer; // Singleton instance of the current player

  String _nickname;
  DateTime _birthdate;
  Position _preferredPosition; // Updated to use Position enum
  List<String> _phoneNumbers;
  String _jerseySize;
  List<String> _teamIds; // Updated to use _teamIds
  List<String> _receivedInvitationIds = []; // Updated to store invitation IDs

  Player({
    String? userId,
    required String email,
    required String nickname,
    required DateTime birthdate,
    required Position preferredPosition, // Updated to use Position enum
    required List<String> phoneNumbers,
    required String jerseySize,
    List<String> teamIds = const [], // Updated to use const parameter
  })  : _nickname = nickname,
        _birthdate = birthdate,
        _preferredPosition = preferredPosition,
        _phoneNumbers = phoneNumbers,
        _jerseySize = jerseySize,
        _teamIds = teamIds, // Initialize _teamIds
        super(userId: userId, email: email, role: UserRole.player);

  static Player? get currentPlayer => _currentPlayer;

  static void setCurrentPlayer(Player player) {
    _currentPlayer = player;
  }

  // Use these getters to expose private fields
  String get nickname => _nickname;
  DateTime get birthdate => _birthdate;
  Position get preferredPosition => _preferredPosition;
  List<String> get phoneNumbers => _phoneNumbers;
  String get jerseySize => _jerseySize;
  String get playerId => userId;
  List<String> get teamIds => _teamIds;
  List<String> get receivedInvitationIds =>
      _receivedInvitationIds; // Getter for received invitation IDs

  void addTeamId(String teamId) {
    if (!_teamIds.contains(teamId)) {
      // Ensure no duplicates
      _teamIds.add(teamId);
    }
  }

  void removeTeamId(String teamId) {
    _teamIds.remove(teamId);
  }

  void addReceivedInvitation(String invitationId) {
    _receivedInvitationIds.add(invitationId);
  }

  void removeReceivedInvitation(String invitationId) {
    _receivedInvitationIds.remove(invitationId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'nickname': _nickname,
      'birthdate': _birthdate.millisecondsSinceEpoch,
      'preferredPosition': _preferredPosition.toString().split('.').last,
      'phoneNumbers': _phoneNumbers,
      'jerseySize': _jerseySize,
      'teamIds': _teamIds,
      'receivedInvitationIds':
          _receivedInvitationIds, // Serialize received invitation IDs
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      userId: json['userId'] as String?,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birthdate: DateTime.fromMillisecondsSinceEpoch(json['birthdate'] as int),
      preferredPosition:
          ParserUtils.parsePosition(json['preferredPosition'] as String),
      phoneNumbers: json['phoneNumbers'] is List
          ? List<String>.from(json['phoneNumbers'])
          : [],
      jerseySize: json['jerseySize'] as String,
      teamIds:
          json['teamIds'] is List ? List<String>.from(json['teamIds']) : [],
    ).._receivedInvitationIds =
        List<String>.from(json['receivedInvitationIds'] ?? []);
  }
}
