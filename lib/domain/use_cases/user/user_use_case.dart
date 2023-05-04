import 'package:navigation_dashboard/domain/models/user/repository/user_repository.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';

class UserUseCase {
  final UserRepository _userRepository;
  UserUseCase(this._userRepository);
  Future createUserWithEmailAndPassword(User user) => _userRepository.addUser(user);
  Future <List<User>> getUsers() => _userRepository.getUsers();
  Stream <User> getUserStatus(String idUser) => _userRepository.getUserStatus(idUser);
  Future <User> getUserById(String idUser) => _userRepository.getUserId(idUser);
  Future <User?> getUserByEmail(String email) => _userRepository.getUserEmail(email);
  Future updateUser(User user) => _userRepository.updateUser(user);
  Future deleteUserById(String idUser) => _userRepository.deleteUser(idUser);
}