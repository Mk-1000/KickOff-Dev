import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/services/iauth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    var currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to send reset password email: ${e.message}');
    }
  }
}
