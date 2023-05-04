import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/favorite/favorite_model.dart';
import '../../../../../domain/models/favorite/repository/favorite_repository.dart';
import '../../../../helpers/collections.dart';
import 'errors/favorite_db_error.dart';

class FavoriteFirestore extends FavoriteRepository {

  final _firestore = FirebaseFirestore.instance;

  @override
  Future addFavorite(Favorite favoriteProduct, String userId) async{
    try {
      await _firestore.collection(Collections.users).doc(userId).collection(Collections.favoriteItems)
            .doc(favoriteProduct.id).set(favoriteProduct.toMap());
    } catch (e) {
      log(e.toString());
    }
  }
  
  @override
  Stream <List<Favorite>> getFavorites(String userId) {
    try {
      StreamController <List<Favorite>> stream = StreamController();
      List<Favorite> favoritesList = [];
      _firestore.collection(Collections.users).doc(userId).collection(Collections.favoriteItems).snapshots().listen((favorites) {
        for(var favorite in favorites.docs){
          favoritesList.add(Favorite.fromMap(favorite.data()));
        }
      });
      stream.add(favoritesList);
      return stream.stream;
    } catch (e) {
      log(e.toString());
      throw GetFavoritesDbError();
    }
  }
  
  @override
  Future <Favorite> getFavorite(String userId, String favoriteId) async{
    try{
      final favoriteData = await _firestore.collection(Collections.users).doc(userId)
            .collection(Collections.favoriteItems).doc(favoriteId).get();
      return Favorite.fromMap(favoriteData.data()!);
    }catch(e){
      log(e.toString());
      throw GetFavoriteDbError();
    }
  }
  
  @override
  Future deleteFavorite(String userId, String favoriteId) async{
    try {
      await _firestore.collection(Collections.users).doc(userId)
            .collection(Collections.favoriteItems).doc(favoriteId).delete();
    } catch (e) {
      log(e.toString());
    }
  }

}
