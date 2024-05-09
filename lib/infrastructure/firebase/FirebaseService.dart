import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Sanitize input for Firebase keys
  String _sanitizeKey(String key) {
    return key.replaceAll('.', ',');
  }

  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(_sanitizeKey(path)).set(data);
  }

  Future<DataSnapshot> getDocument(String path) async {
    return await _database.ref(_sanitizeKey(path)).get();
  }

  Stream<DatabaseEvent> getCollectionStream(String path) {
    return _database.ref(_sanitizeKey(path)).onValue;
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(_sanitizeKey(path)).update(data);
  }

  Future<void> deleteDocument(String path) async {
    final sanitizedPath = _sanitizeKey(path);
    print(
        'Attempting to delete document at: $sanitizedPath'); // Log the sanitized path
    try {
      await _database.ref(sanitizedPath).remove();
      print('Deletion successful for path: $sanitizedPath');
    } catch (e) {
      print('Error deleting document at $sanitizedPath: $e');
      throw Exception('Failed to delete document');
    }
  }
}
