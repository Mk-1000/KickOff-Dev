import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/services/iauth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String cleanEmail(String email) {
    return email.trim().toLowerCase();
  }

  @override
  Future<String> signUpWithEmailPassword(String email, String password) async {
    email = cleanEmail(email); // Clean email before use

    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      return userCredential.user!.uid;
    } else {
      throw Exception('Failed to get user ID');
    }
  }

  @override
  Future<String> signInWithEmailPassword(String email, String password) async {
    email = cleanEmail(email); // Clean email before use

    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      return userCredential.user!.uid;
    } else {
      throw Exception('Failed to get user ID');
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
      email = cleanEmail(email); // Clean email before use
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to send reset password email: ${e.message}');
    }
  }

  @override
  Future<void> signUpWithApple() {
    // TODO: implement signUpWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithFacebook() {
    // TODO: implement signUpWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }
}
