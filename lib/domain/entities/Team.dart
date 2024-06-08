import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PlayerInfo.dart';
import 'package:takwira/utils/IDUtils.dart';

enum Position {
  Goalkeeper,
  Defender,
  Midfielder,
  Forward,
}

class Team {
  String _teamId;
  String _teamName;
  String _captainId;
  Map<String, PlayerInfo> _players;
  String? _chat;
  int _createdAt;
  int _updatedAt;

  static const int _goalkeepers = 1;

  int _defenders;
  int _midfielders;
  int _forwards;

  List<Invitation> _invitations;
  Map<String, String> _filledPositions;

  Team({
    String? teamId,
    required String teamName,
    required String captainId,
    required Map<String, PlayerInfo> players,
    String? chat,
    int? createdAt,
    int? updatedAt,
    required int defenders,
    required int midfielders,
    required int forwards,
    List<Invitation>? invitations,
    Map<String, String>? filledPositions,
  })  : _teamId = teamId ?? IDUtils.generateUniqueId(),
        _teamName = teamName,
        _captainId = captainId,
        _players = players,
        _chat = chat,
        _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch,
        _defenders = defenders,
        _midfielders = midfielders,
        _forwards = forwards,
        _invitations = invitations ?? [],
        _filledPositions = filledPositions ?? {};

  String get teamId => _teamId;
  String get teamName => _teamName;
  String get captainId => _captainId;
  Map<String, PlayerInfo> get players => _players;
  String? get chat => _chat;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;
  int get goalkeepers => _goalkeepers;
  int get defenders => _defenders;
  int get midfielders => _midfielders;
  int get forwards => _forwards;

  set chat(String? value) {
    _chat = value;
  }

  void setPlayerDistribution(int defenders, int midfielders, int forwards) {
    _defenders = defenders;
    _midfielders = midfielders;
    _forwards = forwards;
  }

  void addPlayer(
      String playerId, String playerName, Position position, int number) {
    _players[playerId] = PlayerInfo(
      playerName: playerName,
      position: position,
      number: number,
    );
    _updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void sendInvitation(String playerId, String position, int placeNumber) {
    String positionKey = '$position $placeNumber';
    if (_filledPositions.containsKey(positionKey)) {
      throw Exception(
          'Position $positionKey is already filled by another player.');
    }
    Invitation invitation = Invitation(
      teamId: _teamId,
      playerId: playerId,
      position: positionKey,
    );
    _invitations.add(invitation);
  }

  List<Invitation> get invitations => _invitations;

  bool isPositionFilled(String positionKey) {
    return _filledPositions.containsKey(positionKey);
  }

  void fillPosition(String positionKey, String playerId) {
    _filledPositions[positionKey] = playerId;
    _invitations
        .where((inv) => inv.position == positionKey && inv.playerId != playerId)
        .forEach((inv) => inv.decline());
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': _teamId,
      'teamName': _teamName,
      'captainId': _captainId,
      'players': _players.map((key, value) => MapEntry(key, value.toJson())),
      'chat': _chat,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
      'goalkeepers': _goalkeepers,
      'defenders': _defenders,
      'midfielders': _midfielders,
      'forwards': _forwards,
      'invitations': _invitations.map((inv) => inv.toJson()).toList(),
      'filledPositions': _filledPositions,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? playersJson =
        json['players'] as Map<String, dynamic>?;

    Map<String, PlayerInfo> players = {};
    if (playersJson != null) {
      playersJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          players[key] = PlayerInfo.fromJson(value);
        } else {
          throw Exception('Invalid player info data');
        }
      });
    }

    return Team(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String? ?? 'Unknown Team',
      captainId: json['captainId'] as String? ?? 'Unknown Captain',
      players: players,
      chat: json['chat'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      defenders: json['defenders'] as int? ?? 2,
      midfielders:
          json['midfielders'] as int? ?? 2, // Default value for midfielders
      forwards: json['forwards'] as int? ?? 3,
      invitations: (json['invitations'] as List<dynamic>?)
              ?.map((inv) => Invitation.fromJson(inv as Map<String, dynamic>))
              .toList() ??
          [],
      filledPositions: (json['filledPositions'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as String)) ??
          {},
    );
  }
}
