import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/utils/IDUtils.dart';

import '../../utils/DateTimeUtils.dart';

class Team {
  final String teamId;
  final String teamName;
  final String captainId;
  String? chat;
  final int createdAt;
  int updatedAt;
  final int maxGoalkeepers;
  int maxDefenders;
  int maxMidfielders;
  int maxForwards;
  List<String> players;
  List<PositionSlot> slots;
  Map<String, List<String>> receivedSlotInvitations;
  Map<String, List<String>> sentSlotInvitations;

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
    List<String>? players,
    List<PositionSlot>? slots,
    Map<String, List<String>>? receivedSlotInvitations,
    Map<String, List<String>>? sentSlotInvitations,
  })  : teamId = teamId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        players = players ?? [],
        slots = slots ?? [],
        receivedSlotInvitations = receivedSlotInvitations ?? {},
        sentSlotInvitations = sentSlotInvitations ?? {};

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
          teamId: teamId,
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

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

// Method to add a player to the team
  void addPlayer(String playerId) {
    try {
      if (!players.contains(playerId)) {
        players.add(playerId);
        newUpdate();
      }
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

// Method to remove a player from the team
  void removePlayer(String playerId) {
    try {
      players.remove(playerId);
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void addPlayerToSlot(String playerId, String slotId) {
    try {
      // Check if the player already exists in the team
      if (players.contains(playerId)) {
        throw Exception('Player $playerId already exists in the team');
      }

      final slotIndex = slots.indexWhere((slot) => slot.slotId == slotId);
      if (slotIndex == -1) {
        throw Exception('Slot ID $slotId does not exist');
      }

      if (slots[slotIndex].status != SlotStatus.Reserved) {
        slots[slotIndex].status = SlotStatus.Reserved;
        slots[slotIndex].playerId = playerId;
        addPlayer(playerId);
        newUpdate();
      }
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void changeSlotLimits({
    int? newMaxDefenders,
    int? newMaxMidfielders,
    int? newMaxForwards,
  }) {
    bool hasChanges = false;

    if (newMaxDefenders != null && newMaxDefenders != maxDefenders) {
      maxDefenders = newMaxDefenders;
      hasChanges = true;
    }

    if (newMaxMidfielders != null && newMaxMidfielders != maxMidfielders) {
      maxMidfielders = newMaxMidfielders;
      hasChanges = true;
    }

    if (newMaxForwards != null && newMaxForwards != maxForwards) {
      maxForwards = newMaxForwards;
      hasChanges = true;
    }

    if (hasChanges) {
      try {
        _initializeSlots();
        newUpdate();
      } catch (e) {
        // Handle or log the exception if needed
        rethrow;
      }
    }
  }

  void addReceivedInvitationToSlot(String slotId, String invitationId) {
    try {
      if (!receivedSlotInvitations.containsKey(slotId)) {
        receivedSlotInvitations[slotId] = [];
      }
      receivedSlotInvitations[slotId]!.add(invitationId);
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void removeReceivedInvitationFromSlot(String slotId, String invitationId) {
    try {
      if (!receivedSlotInvitations.containsKey(slotId)) {
        throw Exception('Slot ID $slotId does not exist');
      }
      receivedSlotInvitations[slotId]!.remove(invitationId);
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void addSentInvitationToSlot(String slotId, String invitationId) {
    try {
      if (!sentSlotInvitations.containsKey(slotId)) {
        sentSlotInvitations[slotId] = [];
      }
      sentSlotInvitations[slotId]!.add(invitationId);
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void removeSentInvitationFromSlot(String slotId, String invitationId) {
    try {
      if (!sentSlotInvitations.containsKey(slotId)) {
        throw Exception('Slot ID $slotId does not exist');
      }
      sentSlotInvitations[slotId]!.remove(invitationId);
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  String? getPlayerPosition(String playerId) {
    try {
      for (PositionSlot slot in slots) {
        if (slot.playerId == playerId) {
          return slot.position.toString();
        }
      }
      return null;
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  PositionSlot? getSlotById(String slotId) {
    try {
      final slotIndex = slots.indexWhere((slot) => slot.slotId == slotId);
      if (slotIndex == -1) {
        throw Exception('Slot ID $slotId does not exist');
      }
      return slots[slotIndex];
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  bool isSlotPublic(String slotId) {
    try {
      final slot = getSlotById(slotId);
      return slot?.slotType == SlotType.Public;
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void updateSlotStatusToPublic(String slotId) {
    try {
      final slotIndex = slots.indexWhere((slot) => slot.slotId == slotId);
      if (slotIndex == -1) {
        throw Exception('Slot ID $slotId does not exist');
      }
      if (slots[slotIndex].playerId != null) {
        throw Exception('Slot ID $slotId already has a player assigned');
      }
      slots[slotIndex].slotType = SlotType.Public;
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void updateSlotStatusToPrivate(String slotId) {
    try {
      final slotIndex = slots.indexWhere((slot) => slot.slotId == slotId);
      if (slotIndex == -1) {
        throw Exception('Slot ID $slotId does not exist');
      }
      slots[slotIndex].slotType = SlotType.Private;
      newUpdate();
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  List<PositionSlot> getAllSlots() {
    return List<PositionSlot>.from(slots);
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': teamId,
      'teamName': teamName,
      'captainId': captainId,
      'slots': slots.map((slot) => slot.toJson()).toList(),
      'receivedSlotInvitations': receivedSlotInvitations,
      'sentSlotInvitations': sentSlotInvitations,
      'chat': chat,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'maxGoalkeepers': maxGoalkeepers,
      'maxDefenders': maxDefenders,
      'maxMidfielders': maxMidfielders,
      'maxForwards': maxForwards,
      'players': players,
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
    final players = List<String>.from(json['players'] ?? []);

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
      players: players,
      slots: slots,
      receivedSlotInvitations: receivedSlotInvitations,
      sentSlotInvitations: sentSlotInvitations,
    );
  }
}
