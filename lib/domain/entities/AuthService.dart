import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../services/iauth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<String> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Check if user is successfully created and user ID is available
      if (userCredential.user != null && userCredential.user!.uid.isNotEmpty) {
        return userCredential.user!.uid; // Return the user ID
      } else {
        // If user ID is not available, throw an exception
        throw Exception('Failed to get user ID');
      }
    } on FirebaseAuthException catch (e) {
      // Catch and rethrow FirebaseAuth specific exceptions as general exceptions
      throw Exception('FirebaseAuth Error: ${e.message}');
    }
  }

  // @override
  // Future<void> signUpWithEmailPassword(String email, String password) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception('FirebaseAuth Error: ${e.message}');
  //   }
  // }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuth Error: ${e.message}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuth Error: ${e.message}');
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    }
  }

  @override
  Future<void> signUpWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    await _firebaseAuth.signInWithCredential(oauthCredential);
  }

  @override
  Future<void> signUpWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      await _firebaseAuth.signInWithCredential(credential);
    } else {
      throw Exception('Facebook Sign-In Error: ${result.message}');
    }
  }
}
