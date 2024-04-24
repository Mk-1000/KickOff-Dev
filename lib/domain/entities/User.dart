class User {
  final String _userId;
  final String _email;
  final String _role;
  final String _profile;
  final String _address;
  int _createdAt;
  int _updatedAt;

  User({
    required String userId,
    required String email,
    required String role,
    required String profile,
    required String address,
  })  : _userId = userId,
        _email = email,
        _role = role,
        _profile = profile,
        _address = address,
        _createdAt = DateTime.now().millisecondsSinceEpoch,
        _updatedAt = DateTime.now().millisecondsSinceEpoch;

  String get userId => _userId;
  String get email => _email;
  String get role => _role;
  String get profile => _profile;
  String get address => _address;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'email': _email,
      'role': _role,
      'profile': _profile,
      'address': _address,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      profile: json['profile'] as String,
      address: json['address'] as String,
    )
      .._createdAt =
          json['createdAt'] as int? ?? DateTime.now().millisecondsSinceEpoch
      .._updatedAt =
          json['updatedAt'] as int? ?? DateTime.now().millisecondsSinceEpoch;
  }
}
