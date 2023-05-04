import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/use_cases/order/order_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/order/order_db.dart';

final orderProvider = StateNotifierProvider((ref) => OrdersNotifier());

final orderStreamProvider = StreamProvider.autoDispose<List<Order>>((ref) async*{
  final stream = OrderUseCase(OrderFirestore()).getOrders();
  var orders = const <Order>[];
    await for(final order in stream){
      orders = [...orders, order];
      yield orders;
    }
});

class OrdersNotifier extends StateNotifier <Order?>{

  OrdersNotifier():super(null);

  final OrderUseCase _orderService = OrderUseCase(OrderFirestore());
  List <OrderDetails> ordersItems = [];
  late Order order;

  Future <List<OrderDetails>> getOrdersDetails(String orderId) async{
    return await _orderService.getOrdersDetails(orderId);
  }

  Future <bool> addOrder(Order order, List<Product> products) async {

    /*List<Cart> itemsCart = await _cartService.getProductsShoppingCart();
    
    for(int i = 0; i < itemsCart.length ; i++){
      
      ordersItems.add(OrderDetails(
        reference: itemsCart[i].reference, 
        pinta: itemsCart[i].pinta, 
        pintaDescription: itemsCart[i].pintaDescription, 
        size: itemsCart[i].size, 
        amount: itemsCart[i].amount, 
        price: products[i].price, 
        photoUrl: products[i].photoURL,
        ));
    
    }

    order.id = const Uuid().v4();

    if(await _orderService.addOrder(order)){
      
      for(int i = 0; i < itemsCart.length ; i++){

        final idProduct = products[i].reference + products[i].pinta;
        final idSize = idProduct + itemsCart[i].size;

        ProductSize sizeOrigin = await _productService.get;

        final amount = sizeOrigin.amount - itemsCart[i].amount;

        await _productService.updateSize(
          ProductSizeModel(
            amount: amount, 
            quantityUpdateDate: Timestamp.now(), 
            size: itemsCart[i].size, 
            state: amount > 0 ? Strings.productAvailable : Strings.productNotAvailable
          ) , idProduct );

      }
  
      return true;
    }
  */
    return false;

  }

  Future <bool> deleteOrder(String idOrder) async{
    await _orderService.deleteOrder(idOrder);
    return true;
  }

  Future <void> updateOrder() async{
    state = await _orderService.updateOrder(order);
  }
}