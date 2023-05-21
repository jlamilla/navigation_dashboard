
abstract class AuthRepository {
  Future <Map<String,bool>> addSessionUser(String email, String password);
  Future <String> signInEmailandPassword(String email, String password);
  Future <bool> signOut();
  Future <bool> restorePassword(String email);
  Stream userSessionChanges();
}