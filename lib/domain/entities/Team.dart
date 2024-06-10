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
// }import 'package:takwira/utils/IDUtils.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/utils/IDUtils.dart';

class Team {
  final String teamId;
  final String teamName;
  final String captainId;
  Map<String, PositionSlot> slots;
  String? chat;
  final int createdAt;
  int updatedAt;
  final int maxGoalkeepers = 1;
  int maxDefenders;
  int maxMidfielders;
  int maxForwards;

  Team({
    String? teamId,
    required this.teamName,
    required this.captainId,
    this.chat,
    int? createdAt,
    int? updatedAt,
    this.maxDefenders = 4,
    this.maxMidfielders = 4,
    this.maxForwards = 2,
  })  : teamId = teamId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch,
        slots = _initializeSlots(
          goalkeepers: 1,
          defenders: maxDefenders,
          midfielders: maxMidfielders,
          forwards: maxForwards,
        );

  static Map<String, PositionSlot> _initializeSlots({
    required int goalkeepers,
    required int defenders,
    required int midfielders,
    required int forwards,
  }) {
    Map<String, PositionSlot> slots = {};
    int slotNumber = 1;

    void addSlot(Position position, int count) {
      for (int i = 0; i < count; i++) {
        slots[slotNumber.toString()] = PositionSlot(
          slotId: IDUtils.generateUniqueId(),
          number: slotNumber,
          position: position,
        );
        slotNumber++;
      }
    }

    addSlot(Position.Goalkeeper, goalkeepers);
    addSlot(Position.Defender, defenders);
    addSlot(Position.Midfielder, midfielders);
    addSlot(Position.Forward, forwards);

    return slots;
  }

  void addPlayerToSlot(String slotId, String playerId) {
    if (!slots.containsKey(slotId)) {
      throw Exception('Slot ID $slotId does not exist');
    }
    slots[slotId]!.status = SlotStatus.Reserved;
    slots[slotId]!.playerId = playerId;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void changeSlotLimits({
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  }) {
    if (newMaxDefenders != null) maxDefenders = newMaxDefenders;
    if (newMaxMidfielders != null) maxMidfielders = newMaxMidfielders;
    if (newMaxForwards != null) maxForwards = newMaxForwards;

    slots = _initializeSlots(
      goalkeepers: 1,
      defenders: maxDefenders,
      midfielders: maxMidfielders,
      forwards: maxForwards,
    );

    // Clear players from slots that no longer exist
    slots.forEach((slotId, slot) {
      if (slot.status == SlotStatus.Reserved) {
        slot.status = SlotStatus.Available;
        slot.playerId = null;
      }
    });

    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': teamId,
      'teamName': teamName,
      'captainId': captainId,
      'slots': slots.map((key, slot) => MapEntry(key, slot.toJson())),
      'chat': chat,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'maxGoalkeepers': maxGoalkeepers,
      'maxDefenders': maxDefenders,
      'maxMidfielders': maxMidfielders,
      'maxForwards': maxForwards,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    print('Parsing team JSON: $json');

    final teamId = json['teamId'] as String;
    final teamName = json['teamName'] as String;
    final captainId = json['captainId'] as String;
    final maxGoalkeepers = json['maxGoalkeepers'] as int;
    final maxDefenders = json['maxDefenders'] as int;
    final maxMidfielders = json['maxMidfielders'] as int;
    final maxForwards = json['maxForwards'] as int;
    final createdAt = json['createdAt'] as int?;
    final updatedAt = json['updatedAt'] as int?;
    final chat = json['chat'] as String?;

    print('Slots JSON before parsing: ${json['slots']}');

    final slotsJson = json['slots'];
    if (slotsJson is! List) {
      throw Exception(
          'Expected a list for slots, but found ${slotsJson.runtimeType}');
    }

    // Convert the slotsJson to a Map<String, PositionSlot>
    Map<String, PositionSlot> slots = {};
    List<dynamic> slotsList = slotsJson as List;
    for (var slot in slotsList) {
      if (slot != null) {
        var slotMap = Map<String, dynamic>.from(slot as Map);
        PositionSlot positionSlot = PositionSlot.fromJson(slotMap);
        slots[positionSlot.slotId] = positionSlot;
      }
    }

    return Team(
      teamId: teamId,
      teamName: teamName,
      captainId: captainId,
      chat: chat,
      createdAt: createdAt,
      updatedAt: updatedAt,
      maxDefenders: maxDefenders,
      maxMidfielders: maxMidfielders,
      maxForwards: maxForwards,
    )..slots.addAll(slots);
  }
}
