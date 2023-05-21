import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/use_cases/order/order_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/order/order_db.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';

final orderProvider = StateNotifierProvider.autoDispose((ref) {
  ref.keepAlive();
  return OrdersNotifier();
});
final orderSelectProvider = StateProvider.autoDispose<Order?>((ref) => null);
final orderItemsSelectProvider = StateProvider<List<OrderDetails>>((ref) => []);
final orderColorState = StateProvider.autoDispose<CardColorOrderState?>((ref) => null);

final orderFutureProvider = FutureProvider.autoDispose<List<Order>>((ref) async{
      return await OrderUseCase(OrderFirestore()).getOrders();
},);

final orderDetailsFutureProvider = FutureProvider.autoDispose.family<List<OrderDetails>,String>((ref, String orderId) async{
    return await OrderUseCase(OrderFirestore()).getOrdersDetails(orderId);
});

class OrdersNotifier extends StateNotifier <Order?>{

  OrdersNotifier():super(null);

  final OrderUseCase _orderService = OrderUseCase(OrderFirestore());

  Future <bool> deleteOrder(String idOrder) async{
    bool validate = false;
    await _orderService.deleteOrder(idOrder).whenComplete(() => validate = true);
    return validate;
  }

  Future <bool> updateOrder(Order updateOrder) async{
    bool validate = false;
    state = await _orderService.updateOrder(updateOrder).whenComplete(() => validate = true);
    return validate;
  }
}