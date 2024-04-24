import '../entities/User.dart';

abstract class IUserService {
  Future<User> getUserDetails(String userId);
  Future<void> updateUserDetails(User user);
}
