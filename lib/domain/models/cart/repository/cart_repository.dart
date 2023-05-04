import 'package:navigation_dashboard/domain/models/cart/cart_model.dart';

abstract class CartRepository{
  Future addCartItem(Cart itemProduct, String userId);
  Stream <List<Cart>> getCartItems(String userId);
  Future updateCartItem(Cart itemProduct, String userId);
  Future deleteCartItem(String itemProductId, String userId);
}