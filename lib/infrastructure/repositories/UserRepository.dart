import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/User.dart';
import '../../domain/repositories/IUserRepository.dart';
import '../firebase/FirebaseService.dart';

class UserRepository implements IUserRepository {
  final String _collectionPath = 'Users';
  final FirebaseService _firebaseService;

  UserRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Future<void> addUser(User user) async {
    if (user.userId.isEmpty) {
      throw Exception("User ID is empty");
    }
    await _firebaseService.setDocument(
        '$_collectionPath/${user.userId}', user.toJson());
  }

  Future<User> getUserById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return User.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('User not found');
  }

  Future<void> updateUser(User user) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${user.userId}', user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  Future<List<User>> getAllUsers() async {
    DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
    if (snapshot.exists && snapshot.value != null) {
      Map<dynamic, dynamic> usersMap = snapshot.value as Map<dynamic, dynamic>;
      return usersMap.entries
          .map((e) => User.fromJson(
              Map<String, dynamic>.from(e.value)..['userId'] = e.key))
          .toList();
    }
    return [];
  }
}
