import 'package:takwira/utils/IDUtils.dart';

enum InvitationStatus { pending, accepted, declined }

class Invitation {
  String invitationId;
  String teamId;
  String playerId;
  String position;
  InvitationStatus status;
  int createdAt;
  int updatedAt;

  Invitation({
    String? invitationId,
    required this.teamId,
    required this.playerId,
    required this.position,
    this.status = InvitationStatus.pending,
    int? createdAt,
    int? updatedAt,
  })  : this.invitationId = invitationId ?? IDUtils.generateUniqueId(),
        this.createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        this.updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  void accept() {
    status = InvitationStatus.accepted;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void decline() {
    status = InvitationStatus.declined;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'teamId': teamId,
      'playerId': playerId,
      'position': position,
      'status': status.toString().split('.').last,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'],
      teamId: json['teamId'],
      playerId: json['playerId'],
      position: json['position'],
      status: InvitationStatus.values.firstWhere(
        (e) => e.toString() == 'InvitationStatus.' + json['status'],
      ),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
