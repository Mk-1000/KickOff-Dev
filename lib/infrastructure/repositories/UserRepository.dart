import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/User.dart';
import '../../domain/repositories/IUserRepository.dart';
import '../firebase/FirebaseService.dart';

class UserRepository implements IUserRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'users';

  UserRepository(this._firebaseService);

  // @override
  // Future<List<User>> getAllUsers() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> users =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return users.values
  //         .map((e) => User.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<User>> getAllUsers() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final users = <User>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          users.add(User.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return users; // Return the initially loaded users
  }

  @override
  Future<User> getUserById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return User.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('User not found');
  }

  @override
  Future<void> addUser(User user) async {
    await _firebaseService.addDocument(_collectionPath, user.toJson());
  }

  @override
  Future<void> updateUser(User user) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${user.userId}', user.toJson());
  }

  @override
  Future<void> deleteUser(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }
}
