import 'package:flutter_test/flutter_test.dart';
import 'package:takwira/domain/entities/User.dart';
import 'package:takwira/infrastructure/repositories/UserRepository.dart';

void main() {
  group('UserRepository Integration Tests', () {
    late UserRepository userRepository;
    late String testUserId;

    setUp(() {
      userRepository = UserRepository();

      // Example test user details
      testUserId = 'testUser-${DateTime.now().millisecondsSinceEpoch}';
    });

    test('Add, Retrieve, Update, and Delete a User', () async {
      User testUser = User(
          userId: testUserId,
          email: "test@example.com",
          role: "tester",
          profile: "test profile");

      // Add user
      await userRepository.addUser(testUser);

      // Retrieve user
      User retrievedUser = await userRepository.getUserById(testUserId);
      expect(retrievedUser.userId, equals(testUserId));

      // Update user
      testUser = User(
          userId: testUserId,
          email: "updated@example.com",
          role: "tester",
          profile: "updated profile");
      await userRepository.updateUser(testUser);
      User updatedUser = await userRepository.getUserById(testUserId);
      expect(updatedUser.email, equals("updated@example.com"));

      // Delete user
      await userRepository.deleteUser(testUserId);
      try {
        await userRepository.getUserById(testUserId);
        fail('User should have been deleted');
      } catch (e) {
        expect(e, Exception);
      }
    });

    test('Verify getAllUsers retrieves multiple users', () async {
      // Creating multiple test users
      User user1 = User(
          userId: 'user-${DateTime.now().millisecondsSinceEpoch}',
          email: "user1@example.com",
          role: "user",
          profile: "profile1");

      User user2 = User(
          userId: 'user-${DateTime.now().millisecondsSinceEpoch + 1}',
          email: "user2@example.com",
          role: "user",
          profile: "profile2");

      // Add users
      await userRepository.addUser(user1);
      await userRepository.addUser(user2);

      // Retrieve all users
      List<User> users = await userRepository.getAllUsers();
      expect(users.length, isNotNull);
      expect(users.any((u) => u.userId == user1.userId), isTrue);
      expect(users.any((u) => u.userId == user2.userId), isTrue);

      // Clean up - deleting test users
      await userRepository.deleteUser(user1.userId);
      await userRepository.deleteUser(user2.userId);
    });
  });
}
