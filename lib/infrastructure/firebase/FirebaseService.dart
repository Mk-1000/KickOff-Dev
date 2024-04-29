import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(path).set(data);
  }

  Future<DataSnapshot> getDocument(String path) async {
    return await _database.ref(path).get();
  }

  Stream<DatabaseEvent> getCollectionStream(String path) {
    return _database.ref(path).onValue;
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(path).update(data);
  }

  Future<void> deleteDocument(String path) async {
    await _database.ref(path).remove();
  }
}
