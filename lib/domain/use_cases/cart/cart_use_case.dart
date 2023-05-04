import 'package:navigation_dashboard/domain/models/cart/cart_model.dart';
import 'package:navigation_dashboard/domain/models/cart/repository/cart_repository.dart';

class CartUseCase{

  final CartRepository _cartRepository;
  CartUseCase(this._cartRepository);

  Future addProductShoppingCart(Cart itemProduct, String userId) => _cartRepository.addCartItem(itemProduct, userId);
  Stream <List<Cart>> getProductsShoppingCart(String userId) => _cartRepository.getCartItems(userId);
  Future updateProductsShoppingCart(Cart itemProduct, String userId) => _cartRepository.updateCartItem(itemProduct, userId);
  Future deleteProductsShoppingCart(String itemProductId, String userId) => _cartRepository.deleteCartItem(itemProductId , userId);
}