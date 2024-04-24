abstract class IAuthService {
  Future<void> signUpWithEmailPassword(String email, String password);
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signOut();
  Future<bool> isUserLoggedIn();
  Future<void> resetPassword(String email);
}
