import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';

abstract class OrderRepository{

  Future addOrder(Order order);
  Future addOrderDetails(String orderId, List<OrderDetails> orderDetails);
  Stream <Order> getOrders();
  Future <List<OrderDetails>> getOrdersDetails(String orderId);
  Future updateOrder(Order order);
  Future deleteOrder(String orderId);

}