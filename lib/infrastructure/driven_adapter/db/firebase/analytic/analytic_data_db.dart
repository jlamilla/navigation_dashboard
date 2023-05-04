import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation_dashboard/domain/models/analytic/repository/analytic_repository.dart';
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/collections.dart';

class AnalyticDataFirestore extends AnalyticDataRepository{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Product?> getBestSellingProduct() async{
    Product? bestProduct;
    List<Map<String,int>> idProducts = [];
    try{
      final orders = await _firestore.collection(Collections.orders).get();
      for(var order in orders.docs){
        final orderDetails = await _firestore.collection(Collections.orders).doc(order.id).collection(Collections.ordersDetails).get();
        for(var orderDetail in orderDetails.docs){
          final temp = OrderDetails.fromMap(orderDetail.data());
          idProducts.add({orderDetail.id: temp.amount});
        }
      }

    }catch (error){
      log(error.toString());
    }
    return bestProduct;
  }

  @override
  Future<int> getOrdersCount() async{
    int ordersCount = 0;
    try{
      final orders = await _firestore.collection(Collections.orders).count().get();
      ordersCount = orders.count;
    }catch (error){
      log(error.toString());
    }
    return ordersCount;
  }

  @override
  Future<int> getProductsCount() async{
    int productsCount = 0;
    try{
      final products = await _firestore.collection(Collections.products).count().get();
      productsCount = products.count;
    }catch (error){
      log(error.toString());
    }
    return productsCount;
  }

  @override
  Future <int> getUserCount() async{
    int usersCount = 0;
    try{
      final users = await _firestore.collection(Collections.users).count().get();
      usersCount = users.count;
    }catch (error){
      log(error.toString());
    }
    return usersCount;
  }

}