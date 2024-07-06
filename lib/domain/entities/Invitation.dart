import 'package:takwira/utils/IDUtils.dart';
import 'package:takwira/utils/Parse.dart';

import '../../utils/DateTimeUtils.dart';

enum InvitationStatus {
  Pending,
  Accepted,
  Rejected,
}

enum InvitationType {
  TeamToPlayer,
  PlayerToTeam,
  TeamToTeam,
}

class Invitation {
  final String invitationId;
  final String teamId;
  final String playerId;
  final String slotId;
  final InvitationType invitationType;
  InvitationStatus status;
  int? respondedAt;
  final int createdAt;
  int updatedAt;

  Invitation({
    String? invitationId,
    required this.teamId,
    required this.playerId,
    required this.slotId,
    required this.invitationType,
    this.status = InvitationStatus.Pending,
    this.respondedAt,
    int? createdAt,
    int? updatedAt,
  })  : invitationId = invitationId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  /// Accept the invitation if it is still pending.
  void accept() {
    if (status == InvitationStatus.Pending) {
      status = InvitationStatus.Accepted;
      respondedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
      updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
    } else {
      throw Exception('Cannot accept invitation: Already responded as $status');
    }
  }

  /// Reject the invitation if it is still pending.
  void reject() {
    if (status == InvitationStatus.Pending) {
      status = InvitationStatus.Rejected;
      respondedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
      updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
    } else {
      throw Exception('Cannot reject invitation: Already responded as $status');
    }
  }

  /// Check if the invitation is accepted.
  bool get isAccepted => status == InvitationStatus.Accepted;

  /// Check if the invitation is rejected.
  bool get isRejected => status == InvitationStatus.Rejected;

  /// Check if the invitation is pending.
  bool get isPending => status == InvitationStatus.Pending;

  /// Check if the invitation has been responded to.
  bool get isResponded => status != InvitationStatus.Pending;

  /// Convert the invitation to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'teamId': teamId,
      'playerId': playerId,
      'slotId': slotId,
      'type': invitationType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'respondedAt': respondedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Create an invitation instance from a JSON representation.
  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'] as String?,
      teamId: json['teamId'] as String,
      playerId: json['playerId'] as String,
      slotId: json['slotId'] as String,
      invitationType: ParserUtils.parseInvitationType(json['type'] as String),
      status: ParserUtils.parseInvitationStatus(json['status'] as String),
      respondedAt: json['respondedAt'] as int?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
