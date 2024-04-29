import '../../domain/entities/User.dart';
import '../../domain/services/iauth_service.dart';
import '../../domain/services/iuser_service.dart';
import '../../business/services/auth_service.dart';
import '../../business/services/user_service.dart';

class UserManager {
  final IUserService _userService;
  final IAuthService _authService;

  // Constructor with dependency injection
  UserManager({
    IUserService? userService,
    IAuthService? authService,
  })  : _userService = userService ?? UserService(),
        _authService = authService ?? AuthService();

  List<User> _users = [];
  User? _currentUser;

  // Getters for users and the current user
  List<User> get users => _users;
  User? get currentUser => _currentUser;

  // Method to load all users
  Future<void> loadAllUsers() async {
    _users = await _userService.getAllUsers();
  }

  // Method to load details of a specific user
  Future<void> loadUserDetails(String userId) async {
    _currentUser = await _userService.getUserDetails(userId);
  }

  // Method to add a new user
  Future<void> addUser(User user) async {
    await _userService.addUser(user);
    _users.add(user);
  }

  // Method to update an existing user
  Future<void> updateUser(User user) async {
    await _userService.updateUser(user);
    int index = _users.indexWhere((u) => u.userId == user.userId);
    if (index != -1) {
      _users[index] = user;
    }
  }

  // Method to delete a user
  Future<void> deleteUser(String userId) async {
    await _userService.deleteUser(userId);
    _users.removeWhere((user) => user.userId == userId);
  }

  // Authentication Methods
  // Method to sign up a new user with email and password
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      String userId =
          await _authService.signUpWithEmailPassword(email, password);
      User newUser = User(userId: userId, email: email, role: UserRole.user);
      await addUser(newUser);
    } catch (e) {
      // Properly handle or log the error
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  // Method to sign in a user with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _authService.signInWithEmailPassword(email, password);
      loadUserDetails(email); // Assuming email can uniquely identify a user
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
  }
}
