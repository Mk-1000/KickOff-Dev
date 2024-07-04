import '../../domain/entities/User.dart';
import '../../domain/repositories/IUserRepository.dart';
import '../../domain/services/IUserService.dart';
import '../../infrastructure/repositories/UserRepository.dart';

class UserService implements IUserService {
  final IUserRepository _userRepository;

  UserService({IUserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository();

  @override
  Future<List<User>> getAllUsers() async {
    return await _userRepository.getAllUsers();
  }

  @override
  Future<User> getUserDetails(String userId) async {
    return await _userRepository.getUserById(userId);
  }

  @override
  Future<void> addUser(User user) async {
    await _userRepository.addUser(user);
  }

  @override
  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _userRepository.deleteUser(userId);
  }
}
