import '../../utils/IDUtils.dart';

class User {
  String _userId;
  final String _email;
  final String _role;
  final String _profile;
  int _createdAt;
  int _updatedAt;

  User({
    required String email,
    required String role,
    required String profile,
  })  : _email = email,
        _role = role,
        _profile = profile,
        _userId = IDUtils.generateUniqueId(),
        _createdAt = DateTime.now().millisecondsSinceEpoch,
        _updatedAt = DateTime.now().millisecondsSinceEpoch;

  String get userId => _userId;
  String get email => _email;
  String get role => _role;
  String get profile => _profile;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'email': _email,
      'role': _role,
      'profile': _profile,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      role: json['role'] as String,
      profile: json['profile'] as String,
    )
      .._createdAt =
          json['createdAt'] as int? ?? DateTime.now().millisecondsSinceEpoch
      .._updatedAt =
          json['updatedAt'] as int? ?? DateTime.now().millisecondsSinceEpoch;
  }
}
