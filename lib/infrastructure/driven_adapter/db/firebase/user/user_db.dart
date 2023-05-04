import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/user/repository/user_repository.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/user/errors/user_db_error.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';

class UserFirestore extends UserRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addUser(User user) async{
    bool validateComplete = false;
    try {
      await _firestore.collection(Collections.users).doc(user.id).set(user.toMap()).whenComplete(() => validateComplete=true);
    } catch (e){
      log(e.toString());
      throw GetUserDbError();
    }
    return validateComplete;
  }
  
  @override
  Future <List<User>> getUsers() async{
    try{
      final users = <User>[];
      final usersData = await _firestore.collection(Collections.users).get();
      for(final user in usersData.docs){
        final temp = User.fromMap(user.data());
        temp.id = user.id;
        users.add(temp);
      }
      return users;
    }catch(e){
      log(e.toString());
      throw GetUserDbError();
    }
  }
  
  @override
  Future <User> getUserId(String idUser) async {
    try{
      final userData = await _firestore.collection(Collections.users).doc(idUser).get();
      return User.fromMap(userData.data()!);
    }catch(e){
      log(e.toString());
      throw GetUserByIdDbError();
    }
  }
  
  @override
  Future<User?> getUserEmail(String email) async{
    try{
      User? userProfile;
      final userData = await _firestore.collection(Collections.users).where('email',isEqualTo: email).get();
      for(var user in userData.docs){
        userProfile =  User.fromMap(user.data());
      }
      return userProfile;
    }catch(e){
      log(e.toString());
      throw GetUserByEmailDbError();
    }
  }
  
  @override
  Future updateUser(User user) async{
    try{
      await _firestore.collection(Collections.users).doc(user.id).update(user.toMap());
    }catch(e){
      log(e.toString());
      throw UpdateUserDbError();
    }
  }
  
  @override
  Future deleteUser(String idUser) async{
    try{
      await _firestore.collection(Collections.users).doc(idUser).delete();
    }catch(e){
      log(e.toString());
      throw DeleteUserByIdDbError();
    }
  }
  
  @override
  Stream<User> getUserStatus(String idUser) async*{
    try{
      await for(final user in _firestore.collection(Collections.users).doc(idUser).snapshots()){
        final temp = User.fromMap(user.data()!);
        temp.id = user.id;
        yield temp;
      }
    }catch(e){
      log(e.toString());
      throw DeleteUserByIdDbError();
    }
  }
}