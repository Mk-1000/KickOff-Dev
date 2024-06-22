import '../../utils/IDUtils.dart';

enum UserRole { User, Player, Stadium }

class User {
  // Public fields
  String userId;
  String email;
  int createdAt;
  int updatedAt;
  UserRole role;

  // Constructor with optional userId parameter
  User({
    String? userId, // Optional userId that can be passed in
    required this.email,
    required this.role,
  })  : userId = userId ??
            IDUtils
                .generateUniqueId(), // Use provided userId or generate a new one
        createdAt = DateTime.now().millisecondsSinceEpoch,
        updatedAt = DateTime.now().millisecondsSinceEpoch;

  // Setters for createdAt and updatedAt
  void setCreatedAt(int createdAt) {
    this.createdAt = createdAt;
  }

  void setUpdatedAt(int updatedAt) {
    this.updatedAt = updatedAt;
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'role':
          role.toString().split('.').last, // Ensure only the role name is saved
    };
  }

  // Deserialize from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'], // Accepts userId from JSON, could be null
      email: json['email'],
      role: UserRole.values
          .firstWhere((e) => e.toString().split('.').last == json['role']),
    )
      ..setCreatedAt(json['createdAt'])
      ..setUpdatedAt(json['updatedAt']);
  }
}
