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
  late Map<String, List<String>> receivedSlotInvitations = {};
  late Map<String, List<String>> sentSlotInvitations = {};

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
    receivedSlotInvitations = {};
    sentSlotInvitations = {};
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

    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void addReceivedInvitationToSlot(String slotId, String invitationId) {
    if (!receivedSlotInvitations.containsKey(slotId)) {
      receivedSlotInvitations[slotId] = [];
    }
    receivedSlotInvitations[slotId]!.add(invitationId);
  }

  void removeReceivedInvitationFromSlot(String slotId, String invitationId) {
    if (!receivedSlotInvitations.containsKey(slotId)) {
      throw Exception('Slot ID $slotId does not exist');
    }
    receivedSlotInvitations[slotId]!.remove(invitationId);
  }

  void addSentInvitationToSlot(String slotId, String invitationId) {
    if (!sentSlotInvitations.containsKey(slotId)) {
      sentSlotInvitations[slotId] = [];
    }
    sentSlotInvitations[slotId]!.add(invitationId);
  }

  void removeSentInvitationFromSlot(String slotId, String invitationId) {
    if (!sentSlotInvitations.containsKey(slotId)) {
      throw Exception('Slot ID $slotId does not exist');
    }
    sentSlotInvitations[slotId]!.remove(invitationId);
  }

  PositionSlot? getSlotById(String slotId) {
    final slotIndex = slots!.indexWhere((slot) => slot.slotId == slotId);
    if (slotIndex == -1) {
      throw Exception('Slot ID $slotId does not exist');
    }
    return slots![slotIndex];
  }

  bool isSlotPublic(String slotId) {
    final slot = getSlotById(slotId);
    return slot?.type == Type.Public;
  }

  void updateSlotStatusToPublic(String slotId) {
    final slotIndex = slots!.indexWhere((slot) => slot.slotId == slotId);
    if (slotIndex == -1) {
      throw Exception('Slot ID $slotId does not exist');
    }

    print('test' + slots![slotIndex].toJson().toString());
    slots![slotIndex].type = Type.Public;
    print('test' + slots![slotIndex].toJson().toString());

    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void updateSlotStatusToPrivate(String slotId) {
    final slotIndex = slots!.indexWhere((slot) => slot.slotId == slotId);
    if (slotIndex == -1) {
      throw Exception('Slot ID $slotId does not exist');
    }
    slots![slotIndex].type = Type.Private;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
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
      'receivedSlotInvitations':
          receivedSlotInvitations, // Add received invitations to JSON
      'sentSlotInvitations':
          sentSlotInvitations, // Add sent invitations to JSON
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

    final receivedSlotInvitationsJson = json['receivedSlotInvitations'];

    // Convert receivedSlotInvitationsJson to a Map<String, List<String>> if not null
    Map<String, List<String>> receivedSlotInvitations = {};
    if (receivedSlotInvitationsJson != null) {
      receivedSlotInvitationsJson.forEach((key, value) {
        if (value is List) {
          receivedSlotInvitations[key] = List<String>.from(value);
        } else {
          throw Exception(
              'Invalid format for received slot invitation with key: $key');
        }
      });
    }

    final sentSlotInvitationsJson = json['sentSlotInvitations'];

    // Convert sentSlotInvitationsJson to a Map<String, List<String>> if not null
    Map<String, List<String>> sentSlotInvitations = {};
    if (sentSlotInvitationsJson != null) {
      sentSlotInvitationsJson.forEach((key, value) {
        if (value is List) {
          sentSlotInvitations[key] = List<String>.from(value);
        } else {
          throw Exception(
              'Invalid format for sent slot invitation with key: $key');
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
      ..receivedSlotInvitations.addAll(receivedSlotInvitations)
      ..sentSlotInvitations.addAll(sentSlotInvitations);
  }
}
