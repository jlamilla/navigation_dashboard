
abstract class AuthRepository {
  Future <String> addSessionUser(String email, String password);
  Future <String> signInEmailandPassword(String email, String password);
  Future <bool> signOut();
  Future <bool> restorePassword(String email);
  Stream userSessionChanges();
}