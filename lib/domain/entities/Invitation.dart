import 'package:takwira/utils/IDUtils.dart';
import 'package:takwira/utils/Parse.dart';

enum InvitationStatus {
  Pending,
  Accepted,
  Rejected,
}

class Invitation {
  final String invitationId;
  final String teamId;
  final String playerId;
  final String slotId;
  InvitationStatus status;
  final int sentAt;
  int? respondedAt;
  final int createdAt;
  int updatedAt;

  Invitation({
    String? invitationId,
    required this.teamId,
    required this.playerId,
    required this.slotId,
    this.status = InvitationStatus.Pending,
    required this.sentAt,
    this.respondedAt,
    int? createdAt,
    int? updatedAt,
  })  : invitationId = invitationId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  void accept() {
    if (status == InvitationStatus.Pending) {
      status = InvitationStatus.Accepted;
      respondedAt = DateTime.now().millisecondsSinceEpoch;
      updatedAt = DateTime.now().millisecondsSinceEpoch;
    } else {
      throw Exception('Cannot accept invitation: Already responded');
    }
  }

  void reject() {
    if (status == InvitationStatus.Pending) {
      status = InvitationStatus.Rejected;
      respondedAt = DateTime.now().millisecondsSinceEpoch;
      updatedAt = DateTime.now().millisecondsSinceEpoch;
    } else {
      throw Exception('Cannot reject invitation: Already responded');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'teamId': teamId,
      'playerId': playerId,
      'slotId': slotId,
      'status': status.toString().split('.').last,
      'sentAt': sentAt,
      'respondedAt': respondedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'] as String?,
      teamId: json['teamId'] as String,
      playerId: json['playerId'] as String,
      slotId: json['slotId'] as String,
      status: ParserUtils.parseInvitationStatus(json['status'] as String),
      sentAt: json['sentAt'] as int,
      respondedAt: json['respondedAt'] as int?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }
}
