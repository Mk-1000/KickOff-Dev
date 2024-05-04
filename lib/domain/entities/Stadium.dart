import 'package:takwira/domain/entities/User.dart';

class Stadium extends User {
  String _name;
  int _capacity;
  List<String> _services;
  String _address;
  String _phone;

  Stadium({
    required String email,
    required String name,
    required int capacity,
    required List<String> services,
    required String address,
    required String phone,
  })  : _name = name,
        _capacity = capacity,
        _services = services,
        _address = address,
        _phone = phone,
        super(email: email, role: UserRole.stadium);

  // Stadium ID is now the User ID
  String get stadiumId => userId;

  // Other getters remain the same

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'name': _name,
      'capacity': _capacity,
      'services': _services,
      'address': _address,
      'phone': _phone,
    };
  }

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      email: json['email'],
      name: json['name'],
      capacity: json['capacity'],
      services: List<String>.from(json['services']),
      address: json['address'],
      phone: json['phone'],
    );
  }
}
