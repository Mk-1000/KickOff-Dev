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
    required this.position,
    this.status = InvitationStatus.Pending,
    required this.sentAt,
    this.respondedAt,
    int? createdAt,
    int? updatedAt,
  })  : invitationId = invitationId ?? IDUtils.generateUniqueId(),
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  Invitation copyWith({
    String? invitationId,
    String? teamId,
    String? playerId,
    Position? position,
    InvitationStatus? status,
    int? sentAt,
    int? respondedAt,
    int? createdAt,
    int? updatedAt,
  }) {
    return Invitation(
      invitationId: invitationId ?? this.invitationId,
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      position: position ?? this.position,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      respondedAt: respondedAt ?? this.respondedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  void _updateStatus(InvitationStatus newStatus) {
    status = newStatus;
    respondedAt = DateTime.now().millisecondsSinceEpoch;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void accept() => _updateStatus(InvitationStatus.Accepted);

  void reject() => _updateStatus(InvitationStatus.Rejected);

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'teamId': teamId,
      'playerId': playerId,
      'position': position.toString().split('.').last,
      'status': status.toString().split('.').last,
      'sentAt': sentAt,
      'respondedAt': respondedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError('JSON must not be null');
    }
    return Invitation(
      invitationId: json['invitationId'] as String,
      teamId: json['teamId'] as String,
      playerId: json['playerId'] as String,
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
