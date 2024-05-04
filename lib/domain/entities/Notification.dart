class Notification {
  String _id;
  String _title;
  String _message;
  DateTime _timestamp;
  bool _read;
  String _type; // New field for the type of notification
  Map<String, bool> _target; // New field to indicate targeted players
  String _status; // New field to indicate the read/unread status
  DateTime _createdAt; // New field for creation timestamp
  DateTime _updatedAt; // New field for last update timestamp

  Notification({
    required String id,
    required String title,
    required String message,
    required DateTime timestamp,
    bool read = false,
    required String type,
    required Map<String, bool> target,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _id = id,
        _title = title,
        _message = message,
        _timestamp = timestamp,
        _read = read,
        _type = type,
        _target = target,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get id => _id;
  String get title => _title;
  String get message => _message;
  DateTime get timestamp => _timestamp;
  bool get read => _read;
  String get type => _type;
  Map<String, bool> get target => _target;
  String get status => _status;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'message': _message,
      'timestamp': _timestamp.toIso8601String(),
      'read': _read,
      'type': _type,
      'target': _target,
      'status': _status,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      read: json['read'] as bool? ?? false,
      type: json['type'] as String,
      target: (json['target'] as Map).cast<String, bool>(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
