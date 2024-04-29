abstract class IAuthService {
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signOut();
  Future<bool> isUserLoggedIn();
  Future<void> resetPassword(String email);
  Future<void> signUpWithGoogle();
  Future<void> signUpWithApple();
  Future<void> signUpWithFacebook();
}
