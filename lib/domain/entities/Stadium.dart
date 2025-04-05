import '../../utils/DateTimeUtils.dart';
import '../../utils/IDUtils.dart';
import 'Field.dart';

class Stadium {
  String stadiumId;
  String name;
  String? address;
  String? mainImage;
  String phoneNumber;
  List<String> services;
  DateTime? startAt;
  DateTime? closeAt;
  List<Field> fields;
  final int createdAt;
  int updatedAt;
  bool visibility;

  Stadium({
    required this.name,
    this.address,
    this.mainImage,
    required this.phoneNumber,
    required this.services,
    this.startAt,
    this.closeAt,
    List<Field>? fields,
    int? createdAt,
    int? updatedAt,
    this.visibility = false,
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
        'address': address,
        'mainImage': mainImage,
        'phoneNumber': phoneNumber,
        'services': services,
        'startAt': startAt?.toIso8601String(),
        'closeAt': closeAt?.toIso8601String(),
        'fields': fields.map((field) => field.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'visibility': visibility,
      };

  factory Stadium.fromJson(Map<String, dynamic> json) {
    final fieldsJson = json['fields'] as List;

    List<Field> fields = [];
    try {
      fields = fieldsJson
          .map((fieldsJson) =>
              Field.fromJson(Map<String, dynamic>.from(fieldsJson as Map)))
          .toList();
    } catch (e) {
      print("Error parsing slots: $e");
    }
    return Stadium(
      name: json['name'],
      address: json['address'] as String?,
      mainImage: json['mainImage'] as String?,
      phoneNumber: json['phoneNumber'],
      services: List<String>.from(json['services']),
      startAt: json['startAt'] != null ? DateTime.parse(json['startAt']) : null,
      closeAt: json['closeAt'] != null ? DateTime.parse(json['closeAt']) : null,
      fields: fields,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      visibility: json['visibility'] ?? false,
    )..stadiumId = json['stadiumId'] ?? IDUtils.generateUniqueId();
  }
}
