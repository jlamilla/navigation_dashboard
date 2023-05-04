import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/domain/use_cases/photo/photo_use_case.dart';
import 'package:navigation_dashboard/domain/use_cases/user/user_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/photo/photo_db.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/user/user_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';

final userProvider = StateNotifierProvider<UserNotifier , User?>((ref) => UserNotifier());
final userStatusStreamProvider = StreamProvider.autoDispose<User>(
    (ref) async*{
      yield* UserUseCase(UserFirestore()).getUserStatus(AppPersistentStore.getUserId()!);
    }
);
final usersFutureProvider = FutureProvider.autoDispose<List<User>>((ref) async{
      final users = await UserUseCase(UserFirestore()).getUsers();
      ref.keepAlive();
      return users;
    } 
);
final userDepartmentMunicipal = StateProvider.autoDispose<DepartmentCityType>((ref) => DepartmentCityType.select);
final userColorState = StateProvider.autoDispose<CardColorUserState?>((ref) => null);
final userProfileProvider = Provider<User?>((ref) => null);
final userDataTreatment = StateProvider<bool>((ref) => false);

class UserNotifier extends StateNotifier<User?> {

  final UserUseCase _userService = UserUseCase(UserFirestore());
  final PhotoUseCase _photoService = PhotoUseCase(PhotoStorage());
  User? userProfile;

  UserNotifier():super(null);

  Future <bool> createSellerData(User newUser,String userId, XFile? photo) async {

    newUser.id = userId;
    
    if(photo != null){
      String photoPath  = await _photoService.uploadPhoto(CollectionStorage.users, newUser.id! , photo );
      String photoURL = await _photoService.downloadURL(photoPath);
      newUser.photoPath = photoPath;
      newUser.photoURL = photoURL;
    }else{
      newUser.photoPath = '';
      newUser.photoURL = '';
    }
    return await _userService.createUserWithEmailAndPassword(newUser);
  }

  Future <bool> addUser(User newUser) async {
    newUser.photoPath = '';
    newUser.photoURL = '';
    newUser.department = 'Valle del Cauca';
    newUser.city = 'Cali';
    newUser.address = 'Av. 5b Nte. #21';
    newUser.dateCreate = DateTime.now().toString();
    newUser.dateUpdate = DateTime.now().toString();
    return await _userService.createUserWithEmailAndPassword(newUser);
  }

  Future <bool> getUser(String email) async {
    final user = await _userService.getUserByEmail(email);
    if(user != null){
      state= user;
    }
    return user != null ;
  }

  Future <bool> updateUser(User selectUser, XFile? photo) async {
    
      selectUser.dateUpdate = DateTime.now().toString();
      
      if(photo != null){

        selectUser.photoPath.isNotEmpty ? await _photoService.deletePhoto(selectUser.photoPath): null;
        String photoPath  = await _photoService.uploadPhoto(CollectionStorage.users, selectUser.id! , photo );
        String photoURL = await _photoService.downloadURL(photoPath);

        selectUser.photoPath = photoPath;
        selectUser.photoURL = photoURL;
      }

    return await _userService.updateUser(selectUser);
  }

  deleteUser(User selectUser) async {
    selectUser.photoPath.isNotEmpty ? await _photoService.deletePhoto(selectUser.photoPath): null;
    _userService.deleteUserById(selectUser.id!);
  }

  Future updateUserStatus() async{
    if(state != null ){
      await _userService.updateUser(state!);
    }
  }
  
}