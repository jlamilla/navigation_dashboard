import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/domain/use_cases/auth/auth_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/user/user_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/auth/auth_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/user/user_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier());

final obscureTextProvider = StateProvider.autoDispose<bool>((ref) => true);

class AuthNotifier extends StateNotifier<User?>{

  String email = '';
  String uid = '';
  String password = '';
  late User userProfile;
  final AuthUseCase _auth = AuthUseCase(AuthFirebase());
  final UserUseCase _user = UserUseCase(UserFirestore());

  AuthNotifier():super(null);

  set user(User user){
    userProfile = user;
  }

  Future <Map<String, bool>> createUserWithEmailAndPassword() async{
    return await _auth.createUserWithEmailAndPassword(email, password);
  }

  Future <int> signInEmailandPassword() async {

    //0 user no exist
    //1 user pending
    //2 user inactivate
    //3 user not admin not commercial
    //4 user email and password error
    //5 success

    //validate user exists
    bool user = await validateUser();
    if(!user){
      return 0;
    }
    //validate role user
    if(state?.rol.compareTo(Roles.admin) == 0 || state?.rol.compareTo(Roles.commercial) == 0){
      //validate state user activate
      final stateUser = validateUserState();
      if(stateUser != 4){
        return stateUser;
      }
      //validate if the email and password are correct
      final String userId = await _auth.signInEmailandPassword(email,password);
      if(userId.isEmpty){
        return 4;
      }
      //save user id in data persistence
      AppPersistentStore.setUserId(userId);
      return 5;
    }
    return 3;
  }

  Future <bool> validateUser() async {
    state = await _user.getUserByEmail(email);
    return state != null;
  }

  int validateUserState()  {
    
    if(state!.state == Strings.userPending){
      return 1;
    }

    if(state!.state == Strings.userInactive){
      return 2;
    }

    return 4;
  }

  Future <bool> signOut() async {
    AppPersistentStore.clear();
    return await _auth.signOut();
  }

  Future <bool> restorePassword() async {
    return await _auth.restorePasswordByEmail(email);
  }

  Stream userSessionChanges(){

    return _auth.userSessionChanges();
  }
}