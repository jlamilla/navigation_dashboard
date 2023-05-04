import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/cart/cart_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/use_cases/cart/cart_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/cart/cart_db.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';

final cartProvider = ChangeNotifierProvider((ref) => CartShopProvider());

class CartShopProvider extends ChangeNotifier{

  final CartUseCase _serviceCart = CartUseCase(CartFirestore());
  List<Product> productsItems = [];
  List<Cart> cartItems = [];
  int sumTotalPrice = 0;
  int sumTotalProduct = 0;
  int _value = 0;

  set value (int data){
    _value = data;
    notifyListeners();
  }

  int get value => _value;

  Stream <List<Cart>> getItems(){
    return _serviceCart.getProductsShoppingCart(AppPersistentStore.getUserId() ?? '');
  }

  Future cartItemsRemove(Cart item) async{
    String? userId = AppPersistentStore.getUserId();
    if(userId != null){
      if(await _serviceCart.deleteProductsShoppingCart(item.id!, userId)){
        cartItems.remove(item);
        notifyListeners();
      }
    }
  }

  Future cartItemsAmountRest(int index,) async{
    String? userId = AppPersistentStore.getUserId();
    if(userId != null){
      cartItems[index].amount--;
      if(await _serviceCart.updateProductsShoppingCart(cartItems[index], userId)){
        notifyListeners();
      }
    }
  }
  
  Future cartItemsAmountSum(int index) async{
    String? userId = AppPersistentStore.getUserId();
    if(userId != null){
      cartItems[index].amount++;
      if(await _serviceCart.updateProductsShoppingCart(cartItems[index], userId)){
        notifyListeners();
      }
    }
  }

  Future <bool> addCartItem(Cart item) async{
    String? userId = AppPersistentStore.getUserId();
    if(userId != null){
      return await _serviceCart.addProductShoppingCart(item, userId);
    }else{
      return false;
    }

  }

}