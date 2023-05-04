import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/cart/cart_model.dart';
import 'package:navigation_dashboard/domain/models/cart/repository/cart_repository.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/cart/error/cart_db_error.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';

class CartFirestore extends CartRepository{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addCartItem(Cart itemProduct, String userId) async{
    try {
      await _firestore.collection(Collections.users).doc(userId).collection(Collections.userCartItems)
            .doc(itemProduct.id).set(itemProduct.toMap());
    } catch (e) {
      log(e.toString());
      throw AddCartItemDbError();
    }
  }
  
  @override
  Stream <List<Cart>> getCartItems(String userId) {
    try {
      StreamController <List<Cart>> stream = StreamController();
      List<Cart> cartList = [];
      _firestore.collection(Collections.users).doc(userId).collection(Collections.userCartItems).snapshots().listen((items) {
        for(var item in items.docs){
          cartList.add(Cart.fromMap(item.data()));
        }
      });
      stream.add(cartList);
      return stream.stream;
    } catch (e) {
      log(e.toString());
      throw AddCartItemDbError();
    }
  }
  
  @override
  Future updateCartItem(Cart itemProduct, String userId) async{
    try {
      await _firestore.collection(Collections.users).doc(userId).collection(Collections.userCartItems)
            .doc(itemProduct.id).update({'cartItemUpdateDate':Timestamp.now(),'amount':itemProduct.amount});
    } catch (e) {
      log(e.toString());
      throw UpdateCartItemDbError();
    }
  }

  @override
  Future deleteCartItem(String itemProductId, String userId) async{
    try {
      await _firestore.collection(Collections.users).doc(userId).collection(Collections.userCartItems)
            .doc(itemProductId).delete();
    } catch (e) {
      log(e.toString());
      throw DeleteCartItemDbError();
    }
  }
}