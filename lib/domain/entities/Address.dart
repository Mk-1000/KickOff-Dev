import '../../utils/DateTimeUtils.dart';
import '../../utils/IDUtils.dart';
import '../../utils/Parse.dart';

enum AddressType { PlayerAddress, TeamAddress, StadiumAddress, Address }

class Address {
  String addressId;
  String? street;
  String city;
  String state;
  String? postalCode;
  String country;
  double? latitude;
  double? longitude;
  AddressType addressType;
  final int createdAt;
  int updatedAt;
  String? userId;

  Address({
    this.street,
    required this.addressType,
    required this.city,
    required this.state,
    this.postalCode,
    this.country = 'Tunisie',
    this.latitude,
    this.longitude,
    this.userId,
    int? createdAt,
    int? updatedAt,
  })  : addressId = IDUtils.generateUniqueId(),
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'addressType': addressType.toString().split('.').last,
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
    String addressId =
        json['addressId'] as String? ?? IDUtils.generateUniqueId();

    return Address(
      addressType: json.containsKey('addressType')
          ? ParserUtils.parseAddressType(json['addressType'] as String)
          : AddressType.Address,
      street: json['street'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String? ?? 'Tunisie',
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    )..addressId = addressId;
  }
}
