import 'package:uuid/uuid.dart';

class IDUtils {
  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid
        .v4(); // Generates a version 4 UUID, which is based on random numbers.
  }
}
