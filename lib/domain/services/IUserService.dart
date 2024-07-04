import '../entities/User.dart';

abstract class IUserService {
  Future<List<User>> getAllUsers();
  Future<User> getUserDetails(String userId);
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
}
