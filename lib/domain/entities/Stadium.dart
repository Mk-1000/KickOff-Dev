class Stadium {
  final String _stadiumId;
  final String _name;
  final int _capacity;
  final List<String> _services;
  final String _address;
  final String _phone;
  final String _type;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  Stadium({
    required String stadiumId,
    required String name,
    required int capacity,
    required List<String> services,
    required String address,
    required String phone,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _stadiumId = stadiumId,
        _name = name,
        _capacity = capacity,
        _services = services,
        _address = address,
        _phone = phone,
        _type = type,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get stadiumId => _stadiumId;
  String get name => _name;
  int get capacity => _capacity;
  List<String> get services => _services;
  String get address => _address;
  String get phone => _phone;
  String get type => _type;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'stadiumId': _stadiumId,
      'name': _name,
      'capacity': _capacity,
      'services': _services,
      'address': _address,
      'phone': _phone,
      'type': _type,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      stadiumId: json['stadiumId'] as String,
      name: json['name'] as String,
      capacity: json['capacity'] as int,
      services: List<String>.from(json['services'] as List),
      address: json['address'] as String,
      phone: json['phone'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
