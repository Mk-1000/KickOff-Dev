import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/utils/IDUtils.dart';

class Team {
  final String teamId;
  final String teamName;
  final String captainId;
  late String? chat;
  final int createdAt;
  int updatedAt;
  final int maxGoalkeepers;
  int maxDefenders;
  int maxMidfielders;
  int maxForwards;
  late List<PositionSlot>? slots = [];
  late Map<String, List<String>> slotInvitations = {};

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
    this.maxGoalkeepers = 1,
  })  : teamId = teamId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch {
    slotInvitations = {};
  }

  List<PositionSlot> initializeSlotsList({
    required int goalkeepers,
    required int defenders,
    required int midfielders,
    required int forwards,
  }) {
    List<PositionSlot> slots = [];
    int slotNumber = 1;

    void addSlot(Position position, int count) {
      for (int i = 0; i < count; i++) {
        slots.add(PositionSlot(
          slotId: IDUtils.generateUniqueId(),
          number: slotNumber,
          position: position,
        ));
        slotNumber++;
      }
    }

    addSlot(Position.Goalkeeper, goalkeepers);
    addSlot(Position.Defender, defenders);
    addSlot(Position.Midfielder, midfielders);
    addSlot(Position.Forward, forwards);

    return slots;
  }

  void _initializeSlots() {
    slots = initializeSlotsList(
      goalkeepers: maxGoalkeepers,
      defenders: maxDefenders,
      midfielders: maxMidfielders,
      forwards: maxForwards,
    );
  }

  void addPlayerToSlot(String playerId, String slotId) {
    final index = int.tryParse(slotId);
    if (index == null || index >= slots!.length) {
      throw Exception('Slot ID $slotId does not exist');
    }
    if (slots?[index].status != SlotStatus.Available) {
      throw Exception('Slot $slotId is not available');
    }
    slots?[index].status = SlotStatus.Reserved;
    slots?[index].playerId = playerId;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void changeSlotLimits({
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  }) {
    maxDefenders = newMaxDefenders ?? maxDefenders;
    maxMidfielders = newMaxMidfielders ?? maxMidfielders;
    maxForwards = newMaxForwards ?? maxForwards;

    _initializeSlots();

    slots?.forEach((slot) {
      if (slot.status == SlotStatus.Reserved) {
        slot.status = SlotStatus.Available;
        slot.playerId = null;
      }
    });

    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void addInvitationToSlot(String slotId, String invitationId) {
    if (!slotInvitations.containsKey(slotId)) {
      slotInvitations[slotId] = [];
    }
    slotInvitations[slotId]!.add(invitationId);
  }

  void removeInvitationFromSlot(String slotId, String invitationId) {
    if (!slotInvitations.containsKey(slotId)) {
      throw Exception('Slot ID $slotId does not exist');
    }
    slotInvitations[slotId]!.remove(invitationId);
  }

  List<PositionSlot> getAllSlots() {
    return List<PositionSlot>.from(slots!);
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': teamId,
      'teamName': teamName,
      'captainId': captainId,
      'slots': slots?.map((slot) => slot.toJson()).toList(),
      'slotInvitations': slotInvitations, // Add invitations to JSON
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

    final slotsJson = json['slots'] as List;
    print('slotsJson $slotsJson');
    // Convert the slotsJson to a List<PositionSlot>
    List<PositionSlot> slots = [];
    try {
      slots = slotsJson
          .map((slotJson) =>
              PositionSlot.fromJson(Map<String, dynamic>.from(slotJson as Map)))
          .toList();
    } catch (e) {
      print("Error parsing slots: $e");
    }

    final slotInvitationsJson = json['slotInvitations'];
    print('slotInvitationsJson $slotInvitationsJson');

    // Convert slotInvitationsJson to a Map<String, List<String>> if not null
    Map<String, List<String>> slotInvitations = {};
    if (slotInvitationsJson != null) {
      slotInvitationsJson.forEach((key, value) {
        if (value is List) {
          slotInvitations[key] = List<String>.from(value);
        } else {
          throw Exception('Invalid format for slot invitation with key: $key');
        }
      });
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
    )
      ..slots?.addAll(slots)
      ..slotInvitations.addAll(slotInvitations);
  }
}




// class Team {
//   final String teamId;
//   final String teamName;
//   final String captainId;
//   Map<String, PositionSlot> slots;
//   String? chat;
//   final int createdAt;
//   int updatedAt;
//   final int maxGoalkeepers = 1;
//   int maxDefenders;
//   int maxMidfielders;
//   int maxForwards;

//   Team({
//     String? teamId,
//     required this.teamName,
//     required this.captainId,
//     this.chat,
//     int? createdAt,
//     int? updatedAt,
//     this.maxDefenders = 4,
//     this.maxMidfielders = 4,
//     this.maxForwards = 2,
//   })  : teamId = teamId ?? IDUtils.generateUniqueId(),
//         createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
//         updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch,
//         slots = _initializeSlots(
//           goalkeepers: 1,
//           defenders: maxDefenders,
//           midfielders: maxMidfielders,
//           forwards: maxForwards,
//         );

//   static Map<String, PositionSlot> _initializeSlots({
//     required int goalkeepers,
//     required int defenders,
//     required int midfielders,
//     required int forwards,
//   }) {
//     Map<String, PositionSlot> slots = {};
//     int slotNumber = 1;

//     void addSlot(Position position, int count) {
//       for (int i = 0; i < count; i++) {
//         slots[slotNumber.toString()] = PositionSlot(
//           slotId: IDUtils.generateUniqueId(),
//           number: slotNumber,
//           position: position,
//         );
//         slotNumber++;
//       }
//     }

//     addSlot(Position.Goalkeeper, goalkeepers);
//     addSlot(Position.Defender, defenders);
//     addSlot(Position.Midfielder, midfielders);
//     addSlot(Position.Forward, forwards);

//     return slots;
//   }

//   void addPlayerToSlot(String playerId, String slotId) {
//     if (!slots.containsKey(slotId)) {
//       throw Exception('Slot ID $slotId does not exist');
//     }
//     slots[slotId]!.status = SlotStatus.Reserved;
//     slots[slotId]!.playerId = playerId;
//     updatedAt = DateTime.now().millisecondsSinceEpoch;
//   }

//   void changeSlotLimits({
//     int? newMaxDefenders,
//     int? newMaxMidfielders,
//     int? newMaxForwards,
//   }) {
//     if (newMaxDefenders != null) maxDefenders = newMaxDefenders;
//     if (newMaxMidfielders != null) maxMidfielders = newMaxMidfielders;
//     if (newMaxForwards != null) maxForwards = newMaxForwards;

//     slots = _initializeSlots(
//       goalkeepers: 1,
//       defenders: maxDefenders,
//       midfielders: maxMidfielders,
//       forwards: maxForwards,
//     );

//     // Clear players from slots that no longer exist
//     slots.forEach((slotId, slot) {
//       if (slot.status == SlotStatus.Reserved) {
//         slot.status = SlotStatus.Available;
//         slot.playerId = null;
//       }
//     });

//     updatedAt = DateTime.now().millisecondsSinceEpoch;
//   }

//   void addInvitationToSlot(String slotId, String invitationId) {
//     if (slots.containsKey(slotId)) {
//       slots[slotId]?.addInvitation(invitationId);
//     } else {
//       throw Exception('Slot ID $slotId does not exist');
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'teamId': teamId,
//       'teamName': teamName,
//       'captainId': captainId,
//       'slots': slots.map((key, slot) => MapEntry(key, slot.toJson())),
//       'chat': chat,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'maxGoalkeepers': maxGoalkeepers,
//       'maxDefenders': maxDefenders,
//       'maxMidfielders': maxMidfielders,
//       'maxForwards': maxForwards,
//     };
//   }

//   factory Team.fromJson(Map<String, dynamic> json) {
//     print('Parsing team JSON: $json');

//     final teamId = json['teamId'] as String;
//     final teamName = json['teamName'] as String;
//     final captainId = json['captainId'] as String;
//     final maxGoalkeepers = json['maxGoalkeepers'] as int;
//     final maxDefenders = json['maxDefenders'] as int;
//     final maxMidfielders = json['maxMidfielders'] as int;
//     final maxForwards = json['maxForwards'] as int;
//     final createdAt = json['createdAt'] as int?;
//     final updatedAt = json['updatedAt'] as int?;
//     final chat = json['chat'] as String?;

//     print('Slots JSON before parsing: ${json['slots']}');

//     final slotsJson = json['slots'];
//     if (slotsJson is! List) {
//       throw Exception(
//           'Expected a list for slots, but found ${slotsJson.runtimeType}');
//     }

//     // Convert the slotsJson to a Map<String, PositionSlot>
//     Map<String, PositionSlot> slots = {};
//     List<dynamic> slotsList = slotsJson as List;
//     for (var slot in slotsList) {
//       if (slot != null) {
//         var slotMap = Map<String, dynamic>.from(slot as Map);
//         PositionSlot positionSlot = PositionSlot.fromJson(slotMap);
//         slots[positionSlot.slotId] = positionSlot;
//       }
//     }

//     return Team(
//       teamId: teamId,
//       teamName: teamName,
//       captainId: captainId,
//       chat: chat,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       maxDefenders: maxDefenders,
//       maxMidfielders: maxMidfielders,
//       maxForwards: maxForwards,
//     )..slots.addAll(slots);
//   }
// }

// class Team {
//   final String teamId;
//   final String teamName;
//   final String captainId;
//   String? chat;
//   final int createdAt;
//   int updatedAt;
//   final int maxGoalkeepers = 1;
//   int maxDefenders;
//   int maxMidfielders;
//   int maxForwards;
//   Map<String, PositionSlot> slots = {};

//   Team({
//     String? teamId,
//     required this.teamName,
//     required this.captainId,
//     this.chat,
//     int? createdAt,
//     int? updatedAt,
//     this.maxDefenders = 4,
//     this.maxMidfielders = 4,
//     this.maxForwards = 2,
//   })  : teamId = teamId ?? IDUtils.generateUniqueId(),
//         createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
//         updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch {
//     _initializeSlots();
//   }

//   void _initializeSlots() {
//     // Create slots for defenders
//     for (int i = 1; i <= maxDefenders; i++) {
//       String slotId = IDUtils.generateUniqueId();
//       slots[slotId] = PositionSlot(
//         slotId: slotId,
//         position: Position.Defender,
//         number: i,
//         status: SlotStatus.Available,
//       );
//     }

//     // Create slots for midfielders
//     for (int i = 1; i <= maxMidfielders; i++) {
//       String slotId = IDUtils.generateUniqueId();
//       slots[slotId] = PositionSlot(
//         slotId: slotId,
//         position: Position.Midfielder,
//         number: i,
//         status: SlotStatus.Available,
//       );
//     }

//     // Create slots for forwards
//     for (int i = 1; i <= maxForwards; i++) {
//       String slotId = IDUtils.generateUniqueId();
//       slots[slotId] = PositionSlot(
//         slotId: slotId,
//         position: Position.Forward,
//         number: i,
//         status: SlotStatus.Available,
//       );
//     }
//   }

//   void changeSlotLimits({
//     int? newMaxDefenders,
//     int? newMaxMidfielders,
//     int? newMaxForwards,
//   }) {
//     if (newMaxDefenders != null) {
//       maxDefenders = newMaxDefenders;
//     }
//     if (newMaxMidfielders != null) {
//       maxMidfielders = newMaxMidfielders;
//     }
//     if (newMaxForwards != null) {
//       maxForwards = newMaxForwards;
//     }

//     // Reinitialize slots with updated limits
//     _initializeSlots();
//   }

//   void invitePlayerToSlot(String slotId, String playerId) {
//     if (slots.containsKey(slotId)) {
//       slots[slotId]!.playerId = playerId;
//       slots[slotId]!.status = SlotStatus.Reserved;
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'teamId': teamId,
//       'teamName': teamName,
//       'captainId': captainId,
//       'chat': chat,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'maxGoalkeepers': maxGoalkeepers,
//       'maxDefenders': maxDefenders,
//       'maxMidfielders': maxMidfielders,
//       'maxForwards': maxForwards,
//       'slots': slots.map((key, value) => MapEntry(key, value.toJson())),
//     };
//   }

//   factory Team.fromJson(Map<String, dynamic> json) {
//     final teamId = json['teamId'] as String;
//     final teamName = json['teamName'] as String;
//     final captainId = json['captainId'] as String;
//     final maxDefenders = json['maxDefenders'] as int;
//     final maxMidfielders = json['maxMidfielders'] as int;
//     final maxForwards = json['maxForwards'] as int;
//     final createdAt = json['createdAt'] as int?;
//     final updatedAt = json['updatedAt'] as int?;
//     final chat = json['chat'] as String?;

//     final slotsJson = json['slots'];
//     if (slotsJson == null || slotsJson is! Map<String, dynamic>) {
//       throw Exception('Invalid or missing slots information');
//     }

//     Map<String, PositionSlot> slots = {};
//     (slotsJson as Map<String, dynamic>).forEach((slotId, slotMap) {
//       final positionSlot = PositionSlot.fromJson(slotMap as Map<String, dynamic>);
//       slots[slotId] = positionSlot;
//     });

//     return Team(
//       teamId: teamId,
//       teamName: teamName,
//       captainId: captainId,
//       chat: chat,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       maxDefenders: maxDefenders,
//       maxMidfielders: maxMidfielders,
//       maxForwards: maxForwards,
//     )..slots.addAll(slots);
//   }
// }

// import 'package:takwira/domain/entities/PositionSlot.dart';
// import 'package:takwira/utils/IDUtils.dart';

// class Team {
//   final String teamId;
//   final String teamName;
//   final String captainId;
//   Map<String, PositionSlot> slots;
//   String? chat;
//   final int createdAt;
//   int updatedAt;
//   final int maxGoalkeepers;
//   final int maxDefenders;
//   final int maxMidfielders;
//   final int maxForwards;
//   List<int> positions;

//   Team({
//     String? teamId,
//     required this.teamName,
//     required this.captainId,
//     this.chat,
//     int? createdAt,
//     int? updatedAt,
//     int? maxDefenders,
//     int? maxMidfielders,
//     int? maxForwards,
//   })  : teamId = teamId ?? IDUtils.generateUniqueId(),
//         createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
//         updatedAt =
//             updatedAt ?? createdAt ?? DateTime.now().millisecondsSinceEpoch,
//         maxGoalkeepers = 1,
//         slots = _initializeSlots(
//           goalkeepers: maxGoalkeepers,
//           defenders: maxDefenders ?? 4,
//           midfielders: maxMidfielders ?? 4,
//           forwards: maxForwards ?? 2,
//         ),
//         positions = [0, 0, 0, 0];

//   static Map<String, PositionSlot> _initializeSlots({
//     required int goalkeepers,
//     required int defenders,
//     required int midfielders,
//     required int forwards,
//   }) {
//     Map<String, PositionSlot> slots = {};
//     int slotNumber = 1;

//     void addSlot(Position position, int count) {
//       for (int i = 0; i < count; i++) {
//         slots[slotNumber.toString()] = PositionSlot(
//           slotId: IDUtils.generateUniqueId(),
//           number: slotNumber,
//           position: position,
//         );
//         slotNumber++;
//       }
//     }

//     addSlot(Position.Goalkeeper, goalkeepers);
//     addSlot(Position.Defender, defenders);
//     addSlot(Position.Midfielder, midfielders);
//     addSlot(Position.Forward, forwards);

//     return slots;
//   }

//   void addPlayerToSlot(String playerId, String slotId) {
//     if (!slots.containsKey(slotId)) {
//       throw Exception('Slot ID $slotId does not exist');
//     }
//     slots[slotId]!.status = SlotStatus.Reserved;
//     slots[slotId]!.playerId = playerId;
//     positions[slots[slotId]!.position.index]++;
//     updatedAt = DateTime.now().millisecondsSinceEpoch;
//   }

//   void removePlayerFromSlot(String playerId, String slotId) {
//     if (!slots.containsKey(slotId)) {
//       throw Exception('Slot ID $slotId does not exist');
//     }
//     slots[slotId]!.status = SlotStatus.Available;
//     slots[slotId]!.playerId = null;
//     positions[slots[slotId]!.position.index]--;
//     updatedAt = DateTime.now().millisecondsSinceEpoch;
//   }

//   bool canAddPlayer(Position position) {
//     int availableCount;
//     switch (position) {
//       case Position.Goalkeeper:
//         availableCount = maxGoalkeepers - positions[0];
//         break;
//       case Position.Defender:
//         availableCount = maxDefenders - positions[1];
//         break;
//       case Position.Midfielder:
//         availableCount = maxMidfielders - positions[2];
//         break;
//       case Position.Forward:
//         availableCount = maxForwards - positions[3];
//         break;
//     }
//     return availableCount > 0;
//   }

//   bool isFull() {
//     return positions.reduce((sum, positionCount) => sum + positionCount) >
//         (maxGoalkeepers + maxDefenders + maxMidfielders + maxForwards - 1);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'teamId': teamId,
//       'teamName': teamName,
//       'captainId': captainId,
//       'slots': slots.map((key, slot) => MapEntry(
//             key,
//             {
//               'slotId': slot.slotId,
//               'number': slot.number,
//               'position': slot.position.index,
//               'status': slot.status.index,
//               'playerId': slot.playerId,
//               'invitationIds': slot.invitationIds,
//             },
//           )),
//       'chat': chat,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'maxGoalkeepers': maxGoalkeepers,
//       'maxDefenders': maxDefenders,
//       'maxMidfielders': maxMidfielders,
//       'maxForwards': maxForwards,
//       'positions': positions,
//     };
//   }

//   factory Team.fromJson(Map<String, dynamic> json) {
//     final teamId = json['teamId'] as String;
//     final teamName = json['teamName'] as String;
//     final captainId = json['captainId'] as String;
//     final maxGoalkeepers = json['maxGoalkeepers'] as int;
//     final maxDefenders = json['maxDefenders'] as int;
//     final maxMidfielders = json['maxMidfielders'] as int;
//     final maxForwards = json['maxForwards'] as int;
//     final createdAt = json['createdAt'] as int?;
//     final updatedAt = json['updatedAt'] as int?;
//     final chat = json['chat'] as String?;

//     final slotsJson = json['slots'] as Map<String, dynamic>;
//     Map<String, PositionSlot> slots = {};
//     slotsJson.forEach((key, slotJson) {
//       final slotId = slotJson['slotId'] as String;
//       final number = slotJson['number'] as int;
//       final position = Position.values[slotJson['position'] as int];
//       final status = SlotStatus.values[slotJson['status'] as int];
//       final playerId = slotJson['playerId'] as String?;
//       final invitationIds = slotJson['invitationIds'] as List<String>?;

//       slots[key] = PositionSlot(
//         slotId: slotId,
//         number: number,
//         position: position,
//         status: status,
//         playerId: playerId,
//         invitationIds: invitationIds ?? [],
//       );
//     });

//     return Team(
//       teamId: teamId,
//       teamName: teamName,
//       captainId: captainId,
//       chat: chat,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       maxDefenders: maxDefenders,
//       maxMidfielders: maxMidfielders,
//       maxForwards: maxForwards,
//       slots: slots,
//       positions: List<int>.from(json['positions'] as List<dynamic>),
//     );
//   }
// }
