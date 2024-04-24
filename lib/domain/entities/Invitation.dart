class Invitation {
  final String _invitationId;
  final String _senderId;
  final String _recipientId;
  final String _referenceId;
  final InvitationType _type;
  final InvitationStatus _status;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  Invitation({
    required String invitationId,
    required String senderId,
    required String recipientId,
    required String referenceId,
    required InvitationType type,
    required InvitationStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _invitationId = invitationId,
        _senderId = senderId,
        _recipientId = recipientId,
        _referenceId = referenceId,
        _type = type,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get invitationId => _invitationId;
  String get senderId => _senderId;
  String get recipientId => _recipientId;
  String get referenceId => _referenceId;
  InvitationType get type => _type;
  InvitationStatus get status => _status;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'invitationId': _invitationId,
      'senderId': _senderId,
      'recipientId': _recipientId,
      'referenceId': _referenceId,
      'type': _type.index,
      'status': _status.index,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      invitationId: json['invitationId'] as String,
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      referenceId: json['referenceId'] as String,
      type: InvitationType.values[json['type'] as int],
      status: InvitationStatus.values[json['status'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

enum InvitationType { TeamInvitation, MatchInvitation }

enum InvitationStatus { Pending, Accepted, Declined, Cancelled }
