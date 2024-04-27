import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseDatabase _database;

  FirebaseService() : _database = FirebaseDatabase.instance;

  // Get a single document by its path
  Future<DataSnapshot> getDocument(String path) async {
    return await _database.ref(path).get();
  }

  // Stream the collection updates
  Stream<DatabaseEvent> getCollectionStream(String path) {
    return _database.ref(path).onValue;
  }

  // Add a document with automatic ID generation
  Future<void> addDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(path).push().set(data);
  }

  // Update an existing document by its path
  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(path).update(data);
  }

  // Delete a document by its path
  Future<void> deleteDocument(String path) async {
    await _database.ref(path).remove();
  }

  // Get a DatabaseReference to perform more complex queries
  DatabaseReference getDatabaseReference(String path) {
    return _database.ref(path);
  }

  // Query data by field and value
  Future<DataSnapshot> queryData(
      String path, String field, dynamic value) async {
    return await _database.ref(path).orderByChild(field).equalTo(value).get();
  }

  // Set a document with a specific ID
  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await _database.ref(path).set(data);
  }

  // Get all children at a path as a list of snapshots
  Future<List<DataSnapshot>> getAllChildren(String path) async {
    DataSnapshot snapshot = await _database.ref(path).get();
    if (snapshot.exists && snapshot.value != null) {
      List<DataSnapshot> children = [];
      snapshot.children.forEach((child) {
        children.add(child);
      });
      return children;
    }
    return [];
  }

  // Update specific fields of a document with a specific ID
  Future<void> updateFields(String path, Map<String, dynamic> data) async {
    await _database.ref(path).update(data);
  }
}
