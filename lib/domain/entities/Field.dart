import '../../utils/IDUtils.dart';

class Field {
  String fieldId;
  List<String> images;
  int capacity;
  double matchPrice;

  Field({
    required this.capacity,
    required this.matchPrice,
    List<String>? images,
  })  : fieldId = IDUtils.generateUniqueId(),
        images = images ?? []; // Initialize images with an empty list

  Map<String, dynamic> toJson() => {
        'fieldId': fieldId,
        'images': images,
        'capacity': capacity,
        'matchPrice': matchPrice,
      };

  factory Field.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    try {
      images = List<String>.from(json['images'] ?? []);
    } catch (e) {
      print("Error parsing images: $e");
    }

    return Field(
      images: images,
      capacity: json['capacity'] as int,
      matchPrice: (json['matchPrice'] as num).toDouble(),
    )..fieldId = json['fieldId'] ?? IDUtils.generateUniqueId();
  }
}
