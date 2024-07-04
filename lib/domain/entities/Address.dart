import '../../utils/DateTimeUtils.dart';

class Address {
  String addressId;
  String? street;
  String city;
  String state;
  String? postalCode;
  String country;
  double? latitude;
  double? longitude;
  int createdAt;
  int updatedAt;
  String userId;

  Address({
    required this.addressId,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.userId,
  })  : createdAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'userId': userId,
      };

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      userId: json['userId'] as String,
    )
      ..createdAt = json['createdAt'] as int? ??
          DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch
      ..updatedAt = json['updatedAt'] as int? ??
          DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }
}
