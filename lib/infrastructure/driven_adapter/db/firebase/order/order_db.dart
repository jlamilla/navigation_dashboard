import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart' as model;
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/repository/order_repository.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/order/error/order_db_error.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';

class OrderFirestore extends OrderRepository{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addOrder(model.Order order) async{
    try {
      await _firestore.collection(Collections.orders).doc(order.id).set(order.toMap());
    } catch (e) {
      log(e.toString());
      throw AddOrderDbError();
    }
  }

  @override
  Future addOrderDetails(String orderId, List<OrderDetails> orderDetails) async{
    try {
      for(int i = 0; i < orderDetails.length; i++){
        await _firestore.collection(Collections.orders).doc(orderId).collection(Collections.ordersDetails).doc().set(orderDetails[i].toMap());
      }
    } catch (e) {
      log(e.toString());
      throw AddOrderDbError();
    }
  }

  @override
  Stream <model.Order> getOrders() async*{
    try{
      await for(final ordersData in _firestore.collection(Collections.orders).snapshots()){
        for(final order in ordersData.docs){
          final temp = model.Order.fromMap(order.data());
          temp.id = order.id;
          yield temp;
        }
      }
    }catch (e){
      log(e.toString());
      throw GetOrdersDbError();
    }
  }

  @override
  Future <List<OrderDetails>> getOrdersDetails(String orderId) async{
    try{
      List<OrderDetails> orders = [];
      final ordersData = await _firestore.collection(Collections.orders).doc(orderId).collection(Collections.ordersDetails).get();
      for(var order in ordersData.docs){
        orders.add(OrderDetails.fromMap(order.data()));
      }
      return orders;
    }catch (e){
      log(e.toString());
      throw GetOrderDetailsDbError();
    }
  }

  @override
  Future updateOrder(model.Order order) async{
    try{
      await _firestore.collection(Collections.orders).doc(order.id).update({'status': order.state,'dateUpdate': Timestamp.now()});
    }catch(e){
      log(e.toString());
      throw UpdateOrderDbError();
    }
  }
  
  @override
  Future deleteOrder(String orderId) async{
    try{
        final items = await getOrdersDetails(orderId);
        int amount = 0;
        for(OrderDetails item in items){

          final String idProduct = item.reference+item.pinta;
          final String idProductSize = item.reference+item.pinta+item.size;

          final size = await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProductSize).get();
          final sizeItem = ProductSize.fromMap(size.data()!);

          amount = sizeItem.amount + item.amount;

          await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProductSize).
                update({'amount': amount,'quantityUpdateDate': Timestamp.now()});
                
          await _firestore.collection(Collections.orders).doc(orderId).collection(Collections.ordersDetails).doc(item.id).delete();

        }
      await _firestore.collection(Collections.orders).doc(orderId).delete();
    }catch(e){
      log(e.toString());
      throw DeleteOrderDbError();
    }
  }

}