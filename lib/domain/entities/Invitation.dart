import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/utils/IDUtils.dart';

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
  final Position position;
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
    required this.position,
    this.status = InvitationStatus.Pending,
    required this.sentAt,
    this.respondedAt,
    int? createdAt,
    int? updatedAt,
  })  : invitationId = invitationId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  void accept() {
    _updateStatus(InvitationStatus.Accepted);
  }

  void reject() {
    _updateStatus(InvitationStatus.Rejected);
  }

  void _updateStatus(InvitationStatus newStatus) {
    status = newStatus;
    respondedAt = DateTime.now().millisecondsSinceEpoch;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'teamId': teamId,
      'playerId': playerId,
      'slotId': slotId,
      'position': position.toString().split('.').last,
      'status': status.toString().split('.').last,
      'sentAt': sentAt,
      'respondedAt': respondedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'] as String,
      teamId: json['teamId'] as String,
      playerId: json['playerId'] as String,
      slotId: json['slotId'] as String,
      position: ParserUtils.parsePosition(json['position'] as String),
      status: InvitationStatus.values.firstWhere(
        (status) => status.toString().split('.').last == json['status'],
        orElse: () => InvitationStatus.Pending,
      ),
      sentAt: json['sentAt'] as int,
      respondedAt: json['respondedAt'] as int?,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
    );
  }
}
