

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

final cardUserProvider = StateNotifierProvider.autoDispose<CardUserNotifier, List<AnalyticData>>((ref) => CardUserNotifier());
final cardOrderProvider = StateNotifierProvider.autoDispose<CardOrderNotifier, List<AnalyticData>>((ref) => CardOrderNotifier());

class CardUserNotifier extends StateNotifier <List<AnalyticData>>{
  CardUserNotifier():super([]);

  void cardUser(List<User> users){
    state.clear();
    for(int i = 0; i < users.length; i++){
        state.add(switchCaseColorImageUserCard(i, users));
    }
    //state = data;
  }
  
  AnalyticData switchCaseColorImageUserCard(int position, List<User> users) {
    switch (users[position].state){
        case Strings.userActive:{
          return AnalyticData(
            imageCard: ListElement.userCategoryImage[0],
            color: ListElement.userCategoryColor[1],
          );
        }
        case Strings.userInactive:{
          return AnalyticData(
            imageCard: ListElement.userCategoryImage[1],
            color: ListElement.userCategoryColor[2],
          );
        }
        case Strings.userPending:{
          return AnalyticData(
            imageCard: ListElement.userCategoryImage[2],
            color: ListElement.userCategoryColor[3],
          );
        }
      }
    return AnalyticData();
  }
}

class CardOrderNotifier extends StateNotifier <List<AnalyticData>>{
  CardOrderNotifier():super([]);

  void cardOrder(List<Order> orders){
    state.clear();
    for(int i = 0; i < orders.length; i++){
      state.add(switchCaseColorImageOrderCard(i, orders));
    }
  }

  AnalyticData switchCaseColorImageOrderCard(int position, List<Order> orders){
    switch (orders[position].state){
        case Strings.orderPending:{
          return AnalyticData(
            imageCard: ListElement.orderCategoryImage[0],
            color: ListElement.orderCategoryColor[1],
          );
        }
        case Strings.orderPaid:{
          return AnalyticData(
            imageCard: ListElement.orderCategoryImage[1],
            color: ListElement.orderCategoryColor[2],
          );
        }
        case Strings.orderDispatched:{
          return AnalyticData(
            imageCard: ListElement.orderCategoryImage[2],
            color: ListElement.orderCategoryColor[3],
          );
        }
        case Strings.orderCancel:{
          return AnalyticData(
            imageCard: ListElement.orderCategoryImage[3],
            color: ListElement.orderCategoryColor[4],
          );
        }
        case Strings.orderComplete:{
          return AnalyticData(
            imageCard: ListElement.orderCategoryImage[4],
            color: ListElement.orderCategoryColor[5],
          );
        }
      }
    return AnalyticData();
  }
}