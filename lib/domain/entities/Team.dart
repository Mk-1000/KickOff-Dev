import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/utils/IDUtils.dart';

import '../../utils/DateTimeUtils.dart';

class Team {
  final String teamId;
  final String teamName;
  final String captainId;
  String? chatId;
  final int createdAt;
  int updatedAt;
  final int maxGoalkeepers;
  int maxDefenders;
  int maxMidfielders;
  int maxForwards;
  String? addressId;
  List<String> players;
  List<PositionSlot> slots;
  Map<String, List<String>> receivedSlotInvitations;
  Map<String, List<String>> sentSlotInvitations;

  // New fields for Game
  String? currentGameId;
  List<String> gameHistoryIds;
  List<String> receivedGameInvitationIds;
  List<String> sentGameInvitationIds;

  Team({
    String? teamId,
    required this.teamName,
    required this.captainId,
    this.chatId,
    this.addressId,
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
    this.currentGameId,
    List<String>? gameHistoryIds,
    List<String>? receivedGameInvitationIds,
    List<String>? sentGameInvitationIds,
  })  : teamId = teamId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        players = players ?? [],
        slots = slots ?? [],
        receivedSlotInvitations = receivedSlotInvitations ?? {},
        sentSlotInvitations = sentSlotInvitations ?? {},
        gameHistoryIds = gameHistoryIds ?? [],
        receivedGameInvitationIds = receivedGameInvitationIds ?? [],
        sentGameInvitationIds = sentGameInvitationIds ?? [];

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
    } catch (e) {
      // Handle or log the exception if needed
      rethrow;
    }
  }

  void addGameHistoryId(String id) {
    gameHistoryIds.add(id);
  }

  void removeGameHistoryId(String id) {
    gameHistoryIds.remove(id);
  }

  void addSentGameInvitationIds(String id) {
    sentGameInvitationIds.add(id);
  }

  void removeSentGameInvitationIds(String id) {
    sentGameInvitationIds.remove(id);
  }

  void addReceivedGameInvitationIds(String id) {
    receivedGameInvitationIds.add(id);
  }

  void removeReceivedGameInvitationIds(String id) {
    receivedGameInvitationIds.remove(id);
  }

  void addPlayerToSlot(String playerId, String slotId) {
    try {
      // Check if the player already exists in the team
      if (players.contains(playerId)) {
        throw Exception('Player $playerId already exists in the team');
      }

      final slotIndex =
          slots.indexWhere((slot) => slot.slotId.compareTo(slotId) == 0);
      if (slotIndex == -1) {
        throw Exception('Slot ID $slotId does not exist');
      }

      if (slots[slotIndex].status != SlotStatus.Reserved) {
        slots[slotIndex].status = SlotStatus.Reserved;
        slots[slotIndex].playerId = playerId;
        addPlayer(playerId);
        slots[slotIndex].slotType = SlotType.Private;
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
      'chatId': chatId,
      'addressId': addressId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'maxGoalkeepers': maxGoalkeepers,
      'maxDefenders': maxDefenders,
      'maxMidfielders': maxMidfielders,
      'maxForwards': maxForwards,
      'players': players,
      'currentGameId': currentGameId,
      'gameHistoryIds': gameHistoryIds,
      'receivedGameInvitationIds': receivedGameInvitationIds,
      'sentGameInvitationIds': sentGameInvitationIds,
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
    final chatId = json['chatId'] as String?;
    final addressId = json['addressId'] as String?;
    final slotsJson = json['slots'] as List;
    final players = List<String>.from(json['players'] ?? []);

    final currentGameId = json['currentGameId'] as String?;
    final gameHistoryIds = List<String>.from(json['gameHistoryIds'] ?? []);
    final receivedGameInvitationIds =
        List<String>.from(json['receivedGameInvitationIds'] ?? []);
    final sentGameInvitationIds =
        List<String>.from(json['sentGameInvitationIds'] ?? []);

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
      chatId: chatId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      maxDefenders: maxDefenders,
      maxMidfielders: maxMidfielders,
      maxForwards: maxForwards,
      players: players,
      slots: slots,
      addressId: addressId,
      receivedSlotInvitations: receivedSlotInvitations,
      sentSlotInvitations: sentSlotInvitations,
      currentGameId: currentGameId,
      gameHistoryIds: gameHistoryIds,
      receivedGameInvitationIds: receivedGameInvitationIds,
      sentGameInvitationIds: sentGameInvitationIds,
    );
  }
}
