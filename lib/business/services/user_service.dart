import 'package:takwira/domain/repositories/IUserRepository.dart';
import 'package:takwira/domain/entities/User.dart';

class UserService {
  final IUserRepository _userRepository;
  UserService(this._userRepository);

  Future<User> getUserDetails(String userId) async {
    try {
      return await _userRepository.getUserById(userId);
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<void> updateUserDetails(User user) async {
    try {
      await _userRepository.updateUser(user);
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }
}
