import '../../utils/DateTimeUtils.dart';
import '../../utils/IDUtils.dart';
import 'Address.dart';
import 'Field.dart';

class Stadium {
  String stadiumId;
  String name;
  Address address;
  String? mainImage;
  String phoneNumber;
  List<String> services;
  DateTime startAt;
  DateTime closeAt;
  List<Field> fields;
  final int createdAt;
  int updatedAt;

  Stadium({
    required this.name,
    required this.address,
    String? mainImage,
    required this.phoneNumber,
    required this.services,
    required this.startAt,
    required this.closeAt,
    List<Field>? fields,
    int? createdAt,
    int? updatedAt,
  })  : stadiumId = IDUtils.generateUniqueId(),
        fields = fields ?? [],
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  void addField(Field field) {
    fields.add(field);
    newUpdate();
  }

  void removeField(int index) {
    if (index >= 0 && index < fields.length) {
      fields.removeAt(index);
      newUpdate();
    }
  }

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => {
        'stadiumId': stadiumId,
        'name': name,
        'address': address.toJson(),
        'mainImage': mainImage,
        'phoneNumber': phoneNumber,
        'services': services,
        'startAt': startAt.toIso8601String(),
        'closeAt': closeAt.toIso8601String(),
        'fields': fields.map((field) => field.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      name: json['name'],
      address: Address.fromJson(json['address']),
      mainImage: json['mainImage'] as String?,
      phoneNumber: json['phoneNumber'],
      services: List<String>.from(json['services']),
      startAt: DateTime.parse(json['startAt']),
      closeAt: DateTime.parse(json['closeAt']),
      fields: (json['fields'] as List)
          .map((field) => Field.fromJson(field))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    )..stadiumId = json['stadiumId'] ?? IDUtils.generateUniqueId();
  }
}
