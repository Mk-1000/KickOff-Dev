import '../business/services/user_service.dart';
import '../domain/entities/User.dart';
import '../domain/services/iuser_service.dart';

class UserManager {
  final IUserService _userService;

  UserManager([IUserService? userService])
      : _userService = userService ?? UserService();

  List<User> _users = [];
  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;

  Future<void> loadAllUsers() async {
    _users = await _userService.getAllUsers();
    // Update UI as necessary
  }

  Future<void> loadUserDetails(String userId) async {
    _currentUser = await _userService.getUserDetails(userId);
    // Update UI as needed
  }

  Future<void> addUser(User user) async {
    await _userService.addUser(user);
    _users.add(user);
    // Notify listeners or update UI
  }

  Future<void> updateUser(User user) async {
    await _userService.updateUser(user);
    int index = _users.indexWhere((u) => u.userId == user.userId);
    if (index != -1) {
      _users[index] = user;
      // Update UI manually if necessary
    }
  }

  Future<void> deleteUser(String userId) async {
    await _userService.deleteUser(userId);
    _users.removeWhere((user) => user.userId == userId);
    // Handle UI updates manually
  }
}
