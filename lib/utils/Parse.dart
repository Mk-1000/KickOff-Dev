import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';

class ParserUtils {
  static Position parsePosition(String position) {
    return Position.values
        .firstWhere((e) => e.toString().split('.').last == position);
  }

  static SlotStatus parseSlotStatus(String status) {
    return SlotStatus.values
        .firstWhere((e) => e.toString().split('.').last == status);
  }

  static InvitationStatus parseInvitationStatus(String status) {
    return InvitationStatus.values
        .firstWhere((e) => e.toString().split('.').last == status);
  }

  static Type parseType(String type) {
    return Type.values.firstWhere((e) => e.toString().split('.').last == type);
  }
}
