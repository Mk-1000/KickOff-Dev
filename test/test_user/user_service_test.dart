import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:takwira/business/services/UserService.dart';
import 'package:takwira/domain/entities/User.dart';

import '../Mocks/user/i_user_repository_test.dart.mocks.dart';

void main() {
  group('User Service Tests', () {
    late UserService userService;
    late MockIUserRepository
        mockUserRepository; // Ensure this is the correct type
    late User testUser;

    setUp(() {
      // Corrected: Use the correct type for the mock repository
      mockUserRepository = MockIUserRepository();
      userService = UserService(userRepository: mockUserRepository);
      testUser = User(email: "User@gmail.com", role: UserRole.User);

      // Set up mock responses for your repository
      when(mockUserRepository.getAllUsers())
          .thenAnswer((_) async => [testUser]);
      when(mockUserRepository.getUserById(any))
          .thenAnswer((_) async => testUser);
      when(mockUserRepository.addUser(any)).thenAnswer((_) async => {});
      when(mockUserRepository.updateUser(any)).thenAnswer((_) async => {});
      when(mockUserRepository.deleteUser(any)).thenAnswer((_) async => {});
    });

    test('Get All Users', () async {
      var users = await userService.getAllUsers();
      expect(users, isA<List<User>>());
      expect(users.first.userId, equals(testUser.userId));
      verify(mockUserRepository.getAllUsers()).called(1);
    });

    test('Get User Details', () async {
      var user = await userService.getUserDetails(testUser.userId);
      expect(user, isA<User>());
      expect(user.userId, equals(testUser.userId));
      verify(mockUserRepository.getUserById(testUser.userId)).called(1);
    });

    test('Add User', () async {
      await userService.addUser(testUser);
      verify(mockUserRepository.addUser(testUser)).called(1);
    });

    test('Update User', () async {
      await userService.updateUser(testUser);
      verify(mockUserRepository.updateUser(testUser)).called(1);
    });

    test('Delete User', () async {
      await userService.deleteUser(testUser.userId);
      verify(mockUserRepository.deleteUser(testUser.userId)).called(1);
    });
  });
}
