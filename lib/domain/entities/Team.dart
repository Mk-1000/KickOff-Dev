// import 'package:takwira/domain/entities/Invitation.dart';
// import 'package:takwira/domain/entities/PlayerInfo.dart';
// import 'package:takwira/utils/IDUtils.dart';

// enum Position {
//   Goalkeeper,
//   Defender,
//   Midfielder,
//   Forward,
// }

// class Team {
//   String _teamId;
//   String _teamName;
//   String _captainId;
//   Map<String, PlayerInfo> _players;
//   String? _chat;
//   int _createdAt;
//   int _updatedAt;
//   int _goalkeepers;
//   int _defenders;
//   int _midfielders;
//   int _forwards;
//   List<Invitation> _invitations;
//   Map<String, String> _filledPositions;

//   Team({
//     String? teamId,
//     required String teamName,
//     required String captainId,
//     required Map<String, PlayerInfo> players,
//     String? chat,
//     int? createdAt,
//     int? updatedAt,
//     required int defenders,
//     required int midfielders,
//     required int forwards,
//     required int goalkeepers,
//     List<Invitation>? invitations,
//     Map<String, dynamic>? filledPositions,
//   })  : _teamId = teamId ?? IDUtils.generateUniqueId(),
//         _teamName = teamName,
//         _captainId = captainId,
//         _players = players,
//         _chat = chat,
//         _createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
//         _updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch,
//         _defenders = defenders,
//         _midfielders = midfielders,
//         _forwards = forwards,
//         _goalkeepers = goalkeepers,
//         _invitations = invitations ?? [],
//         _filledPositions = filledPositions?.cast<String, String>() ?? {};

//   String get teamId => _teamId;
//   String get teamName => _teamName;
//   String get captainId => _captainId;
//   Map<String, PlayerInfo> get players => _players;
//   String? get chat => _chat;
//   int get createdAt => _createdAt;
//   int get updatedAt => _updatedAt;
//   int get goalkeepers => _goalkeepers;
//   int get defenders => _defenders;
//   int get midfielders => _midfielders;
//   int get forwards => _forwards;

//   set chat(String? value) {
//     _chat = value;
//   }

//   void setPlayerDistribution(int defenders, int midfielders, int forwards) {
//     _defenders = defenders;
//     _midfielders = midfielders;
//     _forwards = forwards;
//   }

//   void addPlayer(
//       String playerId, String playerName, Position position, int number) {
//     _players[playerId] = PlayerInfo(
//       playerName: playerName,
//       position: position,
//       number: number,
//     );
//     _updatedAt = DateTime.now().millisecondsSinceEpoch;
//   }

//   void sendInvitation(String playerId, String position, int placeNumber) {
//     String positionKey = '$position $placeNumber';
//     if (_filledPositions.containsKey(positionKey)) {
//       throw Exception(
//           'Position $positionKey is already filled by another player.');
//     }
//     Invitation invitation = Invitation(
//       teamId: _teamId,
//       playerId: playerId,
//       position: positionKey,
//     );
//     _invitations.add(invitation);
//   }

//   List<Invitation> get invitations => _invitations;

//   bool isPositionFilled(String positionKey) {
//     return _filledPositions.containsKey(positionKey);
//   }

//   void fillPosition(String positionKey, String playerId) {
//     _filledPositions[positionKey] = playerId;
//     _invitations
//         .where((inv) => inv.position == positionKey && inv.playerId != playerId)
//         .forEach((inv) => inv.decline());
//   }

//   // Convert the team object to JSON format
//   Map<String, dynamic> toJson() {
//     return {
//       'teamId': _teamId,
//       'teamName': _teamName,
//       'captainId': _captainId,
//       'players': _players.map((key, value) => MapEntry(key, value.toJson())),
//       'chat': _chat,
//       'createdAt': _createdAt,
//       'updatedAt': _updatedAt,
//       'defenders': _defenders,
//       'midfielders': _midfielders,
//       'forwards': _forwards,
//       'goalkeepers': _goalkeepers,
//       'invitations': _invitations.map((inv) => inv.toJson()).toList(),
//       'filledPositions': _filledPositions,
//     };
//   }

//   // Factory method to create a team object from JSON format
//   factory Team.fromJson(Map<String, dynamic> json) {
//     print("Team JSON: $json");

//     try {
//       final teamId = json['teamId'] as String;
//       final teamName = json['teamName'] as String;
//       final captainId = json['captainId'] as String;
//       final playersJson = json['players'] as Map<String, dynamic>;
//       final chat = json['chat'] as String?;
//       final createdAt = json['createdAt'] as int?;
//       final updatedAt = json['updatedAt'] as int?;
//       final defenders = json['defenders'] as int;
//       final midfielders = json['midfielders'] as int;
//       final forwards = json['forwards'] as int;
//       final goalkeepers = json['goalkeepers'] as int;
//       final invitationsJson = json['invitations'] as List<dynamic>?;
//       final filledPositions = json['filledPositions'] as Map<String, dynamic>;

//       // Convert invitations to a list of Invitation objects
//       List<Invitation> invitations = (invitationsJson ?? [])
//           .map((inv) => Invitation.fromJson(inv as Map<String, dynamic>))
//           .toList();

//       // Convert players to a map of PlayerInfo objects
//       Map<String, PlayerInfo> players = playersJson
//           .map((key, value) => MapEntry(key, PlayerInfo.fromJson(value)));

//       return Team(
//         teamId: teamId,
//         teamName: teamName,
//         captainId: captainId,
//         players: players,
//         chat: chat,
//         createdAt: createdAt,
//         updatedAt: updatedAt,
//         defenders: defenders,
//         midfielders: midfielders,
//         forwards: forwards,
//         goalkeepers: goalkeepers,
//         invitations: invitations,
//         filledPositions: filledPositions.cast<String, String>(),
//       );
//     } catch (e) {
//       print("Error parsing team JSON: $e");
//       rethrow;
//     }
//   }
// }

// // Helper function to parse Position enum from string
// Position parsePosition(String positionString) {
//   switch (positionString) {
//     case 'Goalkeeper':
//       return Position.Goalkeeper;
//     case 'Defender':
//       return Position.Defender;
//     case 'Midfielder':
//       return Position.Midfielder;
//     case 'Forward':
//       return Position.Forward;
//     default:
//       throw ArgumentError('Invalid position string: $positionString');
//   }
// }

import 'package:takwira/domain/entities/PlayerInfo.dart';
import 'package:takwira/utils/IDUtils.dart'; // Import PlayerInfo class

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
  final int _goalkeepers = 1;
  int _defenders;
  int _midfielders;
  int _forwards;
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
    Map<String, dynamic>? filledPositions,
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
        _filledPositions = filledPositions?.cast<String, String>() ?? {};

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

  bool isPositionFilled(String positionKey) {
    return _filledPositions.containsKey(positionKey);
  }

  void fillPosition(String positionKey, String playerId) {
    _filledPositions[positionKey] = playerId;
  }

  // Convert the team object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'teamId': _teamId,
      'teamName': _teamName,
      'captainId': _captainId,
      'players': _players.map((key, value) => MapEntry(key, value.toJson())),
      'chat': _chat,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
      'defenders': _defenders,
      'midfielders': _midfielders,
      'forwards': _forwards,
      'goalkeepers': _goalkeepers,
      'filledPositions': _filledPositions,
    };
  }

  // Factory method to create a team object from JSON format
  factory Team.fromJson(Map<String, dynamic> json) {
    try {
      final teamId = json['teamId'] as String;
      final teamName = json['teamName'] as String;
      final captainId = json['captainId'] as String;
      final defenders = json['defenders'] as int;
      final midfielders = json['midfielders'] as int;
      final forwards = json['forwards'] as int;
      final createdAt = json['createdAt'] as int?;
      final updatedAt = json['updatedAt'] as int?;
      final chat = json['chat'] as String?;
      final playersJson = json['players'] as Map<String, dynamic>;

      // Adjusted to handle nested player structure
      Map<String, PlayerInfo> players = {};
      playersJson.forEach((key, value) {
        players[key] =
            PlayerInfo.fromJson(value); // Directly pass the nested value
      });

      final filledPositionsJson =
          json['filledPositions'] as Map<String, dynamic>?;

      // Parse filledPositions
      Map<String, String> filledPositionsMap = {};
      if (filledPositionsJson != null) {
        filledPositionsMap = filledPositionsJson.cast<String, String>();
      }

      return Team(
        teamId: teamId,
        teamName: teamName,
        captainId: captainId,
        players: players,
        chat: chat,
        createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt: updatedAt ?? DateTime.now().millisecondsSinceEpoch,
        defenders: defenders,
        midfielders: midfielders,
        forwards: forwards,
        filledPositions: filledPositionsMap,
      );
    } catch (e) {
      print("Error parsing team JSON: $e");
      print(json);
      return Team(
        teamName: '',
        captainId: '',
        players: {},
        defenders: 0,
        midfielders: 0,
        forwards: 0,
      );
    }
  }
}

// Helper function to parse Position enum from string
Position parsePosition(String positionString) {
  switch (positionString) {
    case 'Goalkeeper':
      return Position.Goalkeeper;
    case 'Defender':
      return Position.Defender;
    case 'Midfielder':
      return Position.Midfielder;
    case 'Forward':
      return Position.Forward;
    default:
      throw ArgumentError('Invalid position string: $positionString');
  }
}
