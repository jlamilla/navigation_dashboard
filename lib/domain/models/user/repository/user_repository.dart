import 'package:navigation_dashboard/domain/models/user/user_model.dart';

abstract class UserRepository {
  Future addUser(User user);
  Future <List<User>> getUsers();
  Stream <User> getUserStatus(String idUser);
  Future <User> getUserId(String idUser);
  Future <User?> getUserEmail(String email);
  Future updateUser(User user);
  Future deleteUser(String idUser);
}