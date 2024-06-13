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

  void addPlayerToSlot(String playerId, String slotId) {
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

  void addInvitationToSlot(String slotId, String invitationId) {
    if (slots.containsKey(slotId)) {
      slots[slotId]?.addInvitation(invitationId);
    } else {
      throw Exception('Slot ID $slotId does not exist');
    }
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
