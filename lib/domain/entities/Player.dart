import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/User.dart';
import 'package:takwira/utils/Parse.dart';

import '../../utils/DateTimeUtils.dart';

class Player extends User {
  static Player? _currentPlayer;
  String nickname;
  DateTime birthdate;
  Position preferredPosition;
  String phoneNumber;
  String jerseySize;
  List<String> teamIds;
  List<String> receivedInvitationIds = [];
  List<String> sentInvitationIds = [];
  final int createdAt;
  int updatedAt;

  Player({
    String? userId,
    required String email,
    required this.nickname,
    required this.birthdate,
    required this.preferredPosition,
    required this.phoneNumber,
    required this.jerseySize,
    int? createdAt,
    int? updatedAt,
    this.teamIds = const [],
  })  : createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        super(userId: userId, email: email, role: UserRole.Player);

  static Player? get currentPlayer => _currentPlayer;

  String get playerId => userId;

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  static void setCurrentPlayer(Player player) {
    _currentPlayer = player;
  }

  void addTeamId(String teamId) {
    if (!teamIds.contains(teamId)) {
      // Ensure no duplicates
      teamIds.add(teamId);
    }
  }

  void removeTeamId(String teamId) {
    teamIds.remove(teamId);
  }

  void addReceivedInvitation(String invitationId) {
    if (!receivedInvitationIds.contains(invitationId)) {
      // Ensure no duplicates
      receivedInvitationIds.add(invitationId);
    }
  }

  void removeReceivedInvitation(String invitationId) {
    receivedInvitationIds.remove(invitationId);
  }

  void addSentInvitation(String invitationId) {
    if (!sentInvitationIds.contains(invitationId)) {
      // Ensure no duplicates
      sentInvitationIds.add(invitationId);
    }
  }

  void removeSentInvitation(String invitationId) {
    sentInvitationIds.remove(invitationId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'nickname': nickname,
      'birthdate': birthdate.millisecondsSinceEpoch,
      'preferredPosition': preferredPosition.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'jerseySize': jerseySize,
      'teamIds': teamIds,
      'receivedInvitationIds': receivedInvitationIds,
      'sentInvitationIds': sentInvitationIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
      phoneNumber: json['phoneNumber'],
      jerseySize: json['jerseySize'] as String,
      teamIds:
          json['teamIds'] is List ? List<String>.from(json['teamIds']) : [],
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    )
      ..receivedInvitationIds =
          List<String>.from(json['receivedInvitationIds'] ?? [])
      ..sentInvitationIds = List<String>.from(json['sentInvitationIds'] ?? []);
  }
}
