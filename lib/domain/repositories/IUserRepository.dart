import '../entities/User.dart';

abstract class IUserRepository {
  Future<List<User>> getAllUsers();
  Future<User> getUserById(String id);
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
