import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/domain/use_cases/auth/auth_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/user/user_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/auth/auth_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/user/user_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';
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

  Future <bool> createUserWithEmailAndPassword() async{
    uid = await _auth.createUserWithEmailAndPassword(email, password);
    return uid.isNotEmpty;
  }

  Future <bool> signInEmailandPassword(BuildContext context) async {

    //validate user exists

    bool user = await validateUser();

    if(!user && context.mounted){
      //AlertCustom(context: context).scaffoldMessenger(Strings.errorAlert, Strings.errorUser, ContentType.failure);
      return false;
    }
    //validate state user activate
    if(!validateUserState(context) && context.mounted){
      return false;
    }
    //validate if the email and password are correct
    final String userId = await _auth.signInEmailandPassword(email,password);

    if(userId.isEmpty && context.mounted){
      //AlertCustom(context: context).scaffoldMessenger(Strings.errorAlert, Strings.signInValidate, ContentType.failure);
      return false;
    }
    //save user id in data persistence
    AppPersistentStore.setUserId(userId);
    return true;
  }

  Future <bool> validateUser() async {
    state = await _user.getUserByEmail(email);
    return state != null;
  }

  bool validateUserState(BuildContext context)  {

    if(state!.state == Strings.userPending){
      //AlertCustom(context: context).scaffoldMessenger(Strings.warningAlert, Strings.userAlertPending, ContentType.help);
      return false;
    }

    if(state!.state == Strings.userInactive){
      //AlertCustom(context: context).scaffoldMessenger(Strings.errorAlert, Strings.userAlertInactive, ContentType.failure);
      return false;
    }

    return true;
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