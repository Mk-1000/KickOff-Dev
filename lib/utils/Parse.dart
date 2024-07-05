import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';

import '../domain/entities/Address.dart';
import '../domain/entities/Chat.dart';
import '../domain/entities/User.dart';

class ParserUtils {
  static UserRole parseUserRole(String userRole) {
    return UserRole.values
        .firstWhere((e) => e.toString().split('.').last == userRole);
  }

  static Position parsePosition(String position) {
    return Position.values
        .firstWhere((e) => e.toString().split('.').last == position);
  }

  static SlotStatus parseSlotStatus(String slotStatus) {
    return SlotStatus.values
        .firstWhere((e) => e.toString().split('.').last == slotStatus);
  }

  static InvitationStatus parseInvitationStatus(String invitationStatus) {
    return InvitationStatus.values
        .firstWhere((e) => e.toString().split('.').last == invitationStatus);
  }

  static SlotType parseSlotType(String slotType) {
    return SlotType.values
        .firstWhere((e) => e.toString().split('.').last == slotType);
  }

  static ChatType parseChatType(String chatType) {
    return ChatType.values
        .firstWhere((e) => e.toString().split('.').last == chatType);
  }

  static InvitationType parseInvitationType(String type) {
    return InvitationType.values
        .firstWhere((e) => e.toString().split('.').last == type);
  }

  static AddressType parseAddressType(String type) {
    return AddressType.values
        .firstWhere((e) => e.toString().split('.').last == type);
  }
}
