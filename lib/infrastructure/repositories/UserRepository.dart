import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/User.dart';
import '../../domain/repositories/IUserRepository.dart';
import '../firebase/FirebaseService.dart';

class UserRepository implements IUserRepository {
  final String _collectionPath = 'Users';
  final FirebaseService _firebaseService;

  UserRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addUser(User user) async {
    try {
      if (user.userId.isEmpty) {
        throw Exception("User ID is empty");
      }
      await _firebaseService.setDocument(
          '$_collectionPath/${user.userId}', user.toJson());
      print('User added successfully: ${user.userId}');
    } catch (e) {
      print('Failed to add user: $e');
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$id');
      if (snapshot.exists && snapshot.value != null) {
        return User.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }
      throw Exception('User not found for ID $id');
    } catch (e) {
      print('Error fetching user by ID $id: $e');
      throw Exception('Error fetching user by ID $id: $e');
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${user.userId}', user.toJson());
      print('User updated successfully: ${user.userId}');
    } catch (e) {
      print('Failed to update user: $e');
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$id');
      print('User deleted successfully: $id');
    } catch (e) {
      print('Failed to delete user: $e');
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument(_collectionPath);
      if (snapshot.exists && snapshot.value != null) {
        Map<dynamic, dynamic> usersMap =
            snapshot.value as Map<dynamic, dynamic>;
        return usersMap.entries
            .map((e) => User.fromJson(
                Map<String, dynamic>.from(e.value)..['userId'] = e.key))
            .toList();
      }
      return [];
    } catch (e) {
      print('Failed to retrieve all users: $e');
      throw Exception('Failed to retrieve all users');
    }
  }
}
