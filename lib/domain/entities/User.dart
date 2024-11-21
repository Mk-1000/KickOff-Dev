import '../../utils/IDUtils.dart';
import '../../utils/Parse.dart';

enum UserRole { User, Player, Stadium }

class User {
  String userId;
  String email;
  UserRole role;

  User({
    String? userId, // Optional userId that can be passed in
    required this.email,
    required this.role,
  }) : userId = userId ?? IDUtils.generateUniqueId();

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'role':
          role.toString().split('.').last, // Ensure only the role name is saved
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'], // Accepts userId from JSON, could be null
      email: json['email'],
      role: ParserUtils.parseUserRole(json['role'] as String),
    );
  }
}
