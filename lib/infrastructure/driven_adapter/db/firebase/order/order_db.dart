import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart' as model;
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/repository/order_repository.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/order/error/order_db_error.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';

class OrderFirestore extends OrderRepository{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future <List<model.Order>> getOrders() async{
    try{
      final orders = <model.Order>[];
      final ordersData = await _firestore.collection(Collections.orders).get();
        for(final order in ordersData.docs){
          final temp = model.Order.fromMap(order.data());
          temp.id = order.id;
          orders.add(temp);
        }
      return orders;
    }catch(e){
      log(e.toString());
      throw GetOrdersDbError();
    }
  }

  @override
  Future <List<OrderDetails>> getOrdersDetails(String orderId) async{
    try{
      List<OrderDetails> orderItems = [];
      final ordersData = await _firestore.collection(Collections.orders).doc(orderId).collection(Collections.ordersDetails).get();
      for(var item in ordersData.docs){
        final tempItem = OrderDetails.fromMap(item.data());
        tempItem.id = item.id;
        orderItems.add(tempItem);
      }
      return orderItems;
    }catch (e){
      log(e.toString());
      throw GetOrderDetailsDbError();
    }
  }

  @override
  Future updateOrder(model.Order order) async{
    try{
      await _firestore.collection(Collections.orders).doc(order.id).update({'state': order.state,'dateUpdate': order.dateUpdate});
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
          if(size.data() != null){

            final sizeItem = ProductSize.fromMap(size.data()!);
            amount = sizeItem.amount + item.amount;

            await _firestore.collection(Collections.products).doc(idProduct).collection(Collections.productsSizes).doc(idProductSize).
                  update({'amount': amount,'quantityUpdateDate': Formatter.dateFormat()});  
          }

          await _firestore.collection(Collections.orders).doc(orderId).collection(Collections.ordersDetails).doc(item.id).delete();

        }
      await _firestore.collection(Collections.orders).doc(orderId).delete();
    }catch(e){
      log(e.toString());
      throw DeleteOrderDbError();
    }
  }

}