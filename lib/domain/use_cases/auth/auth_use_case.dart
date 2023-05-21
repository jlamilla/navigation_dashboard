import 'package:navigation_dashboard/domain/models/auth/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase(this._authRepository);

  Future <Map<String,bool>> createUserWithEmailAndPassword(String email, String password) => _authRepository.addSessionUser(email, password);
  Future <String> signInEmailandPassword(String email, String password) => _authRepository.signInEmailandPassword(email,password);
  Future <bool> signOut() => _authRepository.signOut();
  Future <bool> restorePasswordByEmail(String email) => _authRepository.restorePassword(email);
  Stream userSessionChanges() => _authRepository.userSessionChanges();
}