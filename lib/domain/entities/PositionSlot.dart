enum Position {
  Goalkeeper,
  Defender,
  Midfielder,
  Forward,
}

enum SlotStatus {
  Available,
  Reserved,
}

class PositionSlot {
  final String slotId;
  final int number;
  final Position position;
  SlotStatus status;
  String? playerId;
  List<String> invitationIds = []; // Add a list to store invitation IDs

  PositionSlot({
    required this.slotId,
    required this.number,
    required this.position,
    this.status = SlotStatus.Available,
    this.playerId,
  });

  void addInvitation(String invitationId) {
    invitationIds.add(invitationId);
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'number': number,
      'position': position.toString().split('.').last,
      'status': status.toString().split('.').last,
      'playerId': playerId,
      'invitationIds': invitationIds, // Include invitation IDs in JSON
    };
  }

  factory PositionSlot.fromJson(Map<String, dynamic> json) {
    return PositionSlot(
      slotId: json['slotId'] as String,
      number: json['number'] as int,
      position: ParserUtils.parsePosition(json['position'] as String),
      status: ParserUtils.parseSlotStatus(json['status'] as String),
      playerId: json['playerId'] as String?,
    )..invitationIds = List<String>.from(json['invitationIds'] ?? []);
  }
}

class ParserUtils {
  static Position parsePosition(String position) {
    switch (position) {
      case 'Goalkeeper':
        return Position.Goalkeeper;
      case 'Defender':
        return Position.Defender;
      case 'Midfielder':
        return Position.Midfielder;
      case 'Forward':
        return Position.Forward;
      default:
        throw Exception('Unknown position: $position');
    }
  }

  static SlotStatus parseSlotStatus(String status) {
    switch (status) {
      case 'Available':
        return SlotStatus.Available;
      case 'Reserved':
        return SlotStatus.Reserved;
      default:
        throw Exception('Unknown slot status: $status');
    }
  }
}
