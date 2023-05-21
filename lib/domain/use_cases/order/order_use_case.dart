import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/order/repository/order_repository.dart';

class OrderUseCase{
  final OrderRepository _orderRepository;
  OrderUseCase(this._orderRepository);

  Future <List<Order>> getOrders() => _orderRepository.getOrders();
  Future <List<OrderDetails>> getOrdersDetails(String orderId) => _orderRepository.getOrdersDetails(orderId);
  Future updateOrder(Order order) => _orderRepository.updateOrder(order);
  Future deleteOrder(String orderId) => _orderRepository.deleteOrder(orderId);
}