import '../../utils/IDUtils.dart';

class Field {
  String fieldId;
  List<String> images;
  int capacity;
  double matchPrice;

  Field({
    List<String>? images,
    required this.capacity,
    required this.matchPrice,
  })  : fieldId = IDUtils.generateUniqueId(),
        images = images ?? [];

  Map<String, dynamic> toJson() => {
        'fieldId': fieldId,
        'images': images,
        'capacity': capacity,
        'matchPrice': matchPrice,
      };

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      images: List<String>.from(json['images']),
      capacity: json['capacity'],
      matchPrice: json['matchPrice'],
    )..fieldId = json['fieldId'] ?? IDUtils.generateUniqueId();
  }
}
