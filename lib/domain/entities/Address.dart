class Address {
  final String _addressId;
  final String _street;
  final String _city;
  final String _state;
  final String _postalCode;
  final String _country;
  final double _latitude;
  final double _longitude;
  final DateTime _createdAt;
  final DateTime _updatedAt;
  String _userId;

  Address({
    required String addressId,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    required double latitude,
    required double longitude,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
  })  : _addressId = addressId,
        _street = street,
        _city = city,
        _state = state,
        _postalCode = postalCode,
        _country = country,
        _latitude = latitude,
        _longitude = longitude,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _userId = userId;

  String get addressId => _addressId;
  String get street => _street;
  String get city => _city;
  String get state => _state;
  String get postalCode => _postalCode;
  String get country => _country;
  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  String get userId => _userId;

  Map<String, dynamic> toJson() => {
        'addressId': _addressId,
        'street': _street,
        'city': _city,
        'state': _state,
        'postalCode': _postalCode,
        'country': _country,
        'latitude': _latitude,
        'longitude': _longitude,
        'createdAt': _createdAt.toIso8601String(),
        'updatedAt': _updatedAt.toIso8601String(),
        'userId': _userId,
      };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json['addressId'],
        street: json['street'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        userId: json['userId'],
      );
}
