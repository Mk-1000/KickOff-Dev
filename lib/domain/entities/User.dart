import '../../utils/IDUtils.dart';

enum UserRole { user, player, stadium }

class User {
  String _userId;
  String _email;
  int _createdAt;
  int _updatedAt;
  UserRole _role;

  // Modified constructor with optional userId parameter
  User({
    String? userId, // Optional userId that can be passed in
    required String email,
    required UserRole role,
  })  : _userId = userId ??
            IDUtils
                .generateUniqueId(), // Use provided userId or generate a new one
        _email = email,
        _role = role,
        _createdAt = DateTime.now().millisecondsSinceEpoch,
        _updatedAt = DateTime.now().millisecondsSinceEpoch;

  String get userId => _userId;
  String get email => _email;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;
  UserRole get role => _role;

  void setUserId(String userId) {
    _userId = userId;
  }

  void setCreatedAt(int createdAt) {
    _createdAt = createdAt;
  }

  void setUpdatedAt(int updatedAt) {
    _updatedAt = updatedAt;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'email': _email,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
      'role': _role.toString(),
    };
  }

  // Updated factory method to handle potential null userId from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'], // Accepts userId from JSON, could be null
      email: json['email'],
      role: UserRole.values.firstWhere((e) => e.toString() == json['role']),
    )
      ..setCreatedAt(json['createdAt'])
      ..setUpdatedAt(json['updatedAt']);
  }
}
