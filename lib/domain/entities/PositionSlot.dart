import 'package:takwira/utils/Parse.dart';

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

enum Type {
  Public,
  Private,
}

class PositionSlot {
  final String slotId;
  final int number;
  final Position position;
  SlotStatus status;
  String? playerId;
  Type type;

  PositionSlot({
    required this.slotId,
    required this.number,
    required this.position,
    this.status = SlotStatus.Available,
    this.playerId,
    this.type = Type.Private,
  });

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'number': number,
      'position': position.toString().split('.').last,
      'status': status.toString().split('.').last,
      'playerId': playerId,
      'type': type.toString().split('.').last
    };
  }

  factory PositionSlot.fromJson(Map<String, dynamic> json) {
    return PositionSlot(
      slotId: json['slotId'] as String,
      number: json['number'] as int,
      position: ParserUtils.parsePosition(json['position'] as String),
      status: ParserUtils.parseSlotStatus(json['status'] as String),
      playerId: json['playerId'] as String?,
      type: json.containsKey('type')
          ? ParserUtils.parseType(json['type'] as String)
          : Type.Private,
    );
  }
}
