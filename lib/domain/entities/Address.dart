import '../../utils/DateTimeUtils.dart';

class Address {
  String _addressId;
  String _street;
  String _city;
  String _state;
  String _postalCode;
  String _country;
  double _latitude;
  double _longitude;
  int _createdAt;
  int _updatedAt;
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
    required String userId,
  })  : _addressId = addressId,
        _street = street,
        _city = city,
        _state = state,
        _postalCode = postalCode,
        _country = country,
        _latitude = latitude,
        _longitude = longitude,
        _userId = userId,
        _createdAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        _updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  String get addressId => _addressId;
  String get street => _street;
  String get city => _city;
  String get state => _state;
  String get postalCode => _postalCode;
  String get country => _country;
  double get latitude => _latitude;
  double get longitude => _longitude;
  int get createdAt => _createdAt;
  int get updatedAt => _updatedAt;
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
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
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
        userId: json['userId'],
      )
        .._createdAt = json['createdAt'] as int? ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch
        .._updatedAt = json['updatedAt'] as int? ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
}
