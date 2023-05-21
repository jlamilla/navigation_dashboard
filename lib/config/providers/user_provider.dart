import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/domain/use_cases/auth/auth_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/photo/photo_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/user/user_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/auth/auth_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/photo_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/user/user_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:uuid/uuid.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier , User?>((ref) {
  ref.keepAlive();
  return UserNotifier();
});

final userSelectProvider = StateProvider.autoDispose<User?>((ref) => null);

final userStatusStreamProvider = StreamProvider.autoDispose<User>(
    (ref) async*{
      yield* UserUseCase(UserFirestore()).getUserStatus(AppPersistentStore.getUserId()!);
    }
);
final usersFutureProvider = FutureProvider.autoDispose<List<User>>((ref) async{
      final users = await UserUseCase(UserFirestore()).getUsers();
      return users;
    } 
);

final userDepartmentMunicipal = StateProvider.autoDispose<DepartmentCityType?>((ref) => null);
final userColorState = StateProvider.autoDispose<CardColorUserState?>((ref) => null);
final userProfileProvider = Provider<User?>((ref) => null);

class UserNotifier extends StateNotifier<User?> {

  final UserUseCase _userService = UserUseCase(UserFirestore());
  final PhotoUseCase _photoService = PhotoUseCase(PhotoStorage());
  final AuthUseCase _authService = AuthUseCase(AuthFirebase());

  UserNotifier():super(null);

  Future <bool> addUser(User newUser, XFile? photo,) async {

    final password = const Uuid().v4();
    final mapValidate = await _authService.createUserWithEmailAndPassword(newUser.email, password);
    if(mapValidate.values.toList()[0]){
      newUser.id = mapValidate.keys.toList()[0];
      _authService.restorePasswordByEmail(newUser.email);
      if(photo != null){
        String photoPath  = await _photoService.uploadPhoto(CollectionStorage.users, newUser.id! , photo );
        String photoURL = await _photoService.downloadURL(photoPath);
        newUser.photoPath = photoPath;
        newUser.photoURL = photoURL;
      }else{
        newUser.photoPath = '';
        newUser.photoURL = '';
      }
      newUser.dateCreate = DateTime.now().toString();
      newUser.dateUpdate = DateTime.now().toString();
      return await _userService.createUserWithEmailAndPassword(newUser);
    }
    return false;
  }

  Future <bool> getUser(String email) async {
    final user = await _userService.getUserByEmail(email);
    if(user != null){
      state= user;
    }
    return user != null ;
  }

  Future <bool> updateUser(User selectUser, XFile? photo) async {
    
    bool validate = false;
      
    if(photo != null){
      selectUser.photoPath.isNotEmpty ? await _photoService.deletePhoto(selectUser.photoPath): null;
      String photoPath  = await _photoService.uploadPhoto(CollectionStorage.users, selectUser.id! , photo );
      String photoURL = await _photoService.downloadURL(photoPath);
      selectUser.photoPath = photoPath;
      selectUser.photoURL = photoURL;
    }
    
    await _userService.updateUser(selectUser).whenComplete(() => validate = true);

    return validate;
  }

  Future<bool> deleteUser(User selectUser) async {
    bool validate = false;
    selectUser.photoPath.isNotEmpty ? await _photoService.deletePhoto(selectUser.photoPath): null;
    await _userService.deleteUserById(selectUser.id!).whenComplete(() => validate = true);
    return validate;
  }

  Future updateUserStatus() async{
    if(state != null ){
      await _userService.updateUser(state!);
    }
  }
  
}