import 'package:takwira/utils/Parse.dart';

import '../../utils/DateTimeUtils.dart';

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

enum SlotType {
  Public,
  Private,
}

class PositionSlot {
  String slotId;
  String teamId;
  int number;
  Position position;
  SlotStatus status;
  int slotTypeChangedAt; // Renamed from typeChangedAt
  String? playerId;
  SlotType _slotType; // Renamed from _type

  PositionSlot({
    required this.slotId,
    required this.number,
    required this.position,
    required this.teamId,
    this.status = SlotStatus.Available,
    this.playerId,
    SlotType slotType = SlotType.Private, // Renamed from Type.Private
  })  : _slotType = slotType,
        slotTypeChangedAt =
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  SlotType get slotType => _slotType; // Renamed from type

  set slotType(SlotType newType) {
    // Renamed from type
    if (_slotType != newType) {
      _slotType = newType;
      slotTypeChangedAt =
          DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'teamId': teamId,
      'number': number,
      'position': position.toString().split('.').last,
      'status': status.toString().split('.').last,
      'slotTypeChangedAt': slotTypeChangedAt, // Renamed from typeChangedAt
      'playerId': playerId,
      'slotType': slotType.toString().split('.').last, // Renamed from type
    };
  }

  factory PositionSlot.fromJson(Map<String, dynamic> json) {
    final positionSlot = PositionSlot(
      slotId: json['slotId'] as String,
      teamId: json['teamId'] as String,
      number: json['number'] as int,
      position: ParserUtils.parsePosition(json['position'] as String),
      status: ParserUtils.parseSlotStatus(json['status'] as String),
      playerId: json['playerId'] as String?,
      slotType: json.containsKey('slotType')
          ? ParserUtils.parseSlotType(json['slotType'] as String)
          : SlotType.Private,
    );
    positionSlot.slotTypeChangedAt =
        json['slotTypeChangedAt'] as int; // Renamed from typeChangedAt
    return positionSlot;
  }
}
