
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/domain/use_cases/analytic/analytic_data_use_case.dart';
import 'package:navigation_dashboard/infrastructure/driven_adapter/db/firebase/analytic/analytic_data_db.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';
import 'package:navigation_design/tokens/colors.dart';

enum ElementsCategoryType{
  dashboard(dataTitle: ListElement.dashboardCategoryTitle, dataColor: ListElement.dashboardCategoryColor),
  products(dataTitle: ListElement.productCategoryTitle , dataColor: ListElement.productCategoryColor),
  users(dataTitle: ListElement.userCategoryTitle , dataColor: ListElement.userCategoryColor ),
  orders(dataTitle: ListElement.orderCategoryTitle , dataColor: ListElement.orderCategoryColor);

  const ElementsCategoryType({
    required this.dataTitle,
    required this.dataColor,
  });

  final List<String> dataTitle;
  final List<Color?> dataColor;
}

final analyticDataProvider = FutureProvider.family.autoDispose<List<AnalyticData>, List?>((ref, List? externalData) async{

    final index = ref.watch(drawerIndexProvider);
    final indexType = ref.watch(drawerIndexTypeProvider);
    List<AnalyticData> dataCategory = [];
    String categoryName = '';
    final AnalyticDataCondition analyticDataCondition;
    List<String> dataTitle = [];
    List<Color?> dataColor = [];
    if(index == indexType.dashboard){
      analyticDataCondition = AnalyticDataCondition();
      dataTitle = ElementsCategoryType.dashboard.dataTitle;
      dataColor = ElementsCategoryType.dashboard.dataColor;
    }else if(index == indexType.products){
      categoryName = ref.watch(searchProductsCategoryProvider);
      analyticDataCondition = AnalyticDataCondition(products: externalData?.cast<Product>());
      dataTitle = ElementsCategoryType.products.dataTitle;
      dataColor = ElementsCategoryType.products.dataColor;
    } else if (index == indexType.users){
      categoryName = ref.watch(searchUsersCategoryProvider);
      analyticDataCondition = AnalyticDataCondition(users: externalData?.cast<User>());
      dataTitle = ElementsCategoryType.users.dataTitle;
      dataColor = ElementsCategoryType.users.dataColor;
    }else{
      categoryName = ref.watch(searchOrdersCategoryProvider);
      analyticDataCondition = AnalyticDataCondition(orders: externalData?.cast<Order>());
      dataTitle = ElementsCategoryType.orders.dataTitle;
      dataColor = ElementsCategoryType.orders.dataColor;
    }
    
    for(int i = 0; i < dataTitle.length; i++){
        dataCategory.add(AnalyticData(
          title: dataTitle[i],
          color: categoryName == dataTitle[i] ? dataColor[i] : white,
          imageCategory: categoryName == dataTitle[i] ? Images.maskCategoryActivate : Images.maskCategory ,
          count: await analyticDataCondition.switchCaseCount(index ?? 0, i , indexType),
        ));
    }
    
    return dataCategory;
});

final analyticDataCardProvider = StateProvider<List<AnalyticData>>((ref)=> []);

class AnalyticDataCondition{

  AnalyticDataCondition({this.products,this.users, this.orders});

  final List<Product>? products;
  final List<User>? users;
  final List<Order>? orders;
  final AnalyticDataUseCase analytic = AnalyticDataUseCase(AnalyticDataFirestore());

  Future<int> switchCaseCount(int index, int position, DrawerIndex indexType) async{

    if(index == indexType.dashboard){
      return await dashboardCount(position);
    }else if(index == indexType.products){
      return position == 0 
        ? products!.length 
        : products!.where((p) => ( 0 == p.state.toLowerCase().compareTo(ListElement.productCategoryTitle[position].toLowerCase()))).toList().length;
    } else if (index == indexType.users){
      return position == 0 
        ? users!.length 
        : users!.where((u) => ( 0 == u.state.toLowerCase().compareTo(ListElement.userCategoryTitle[position].toLowerCase()))).toList().length;  
    }else if (index == indexType.orders){
      return position == 0 
        ? orders!.length 
        : orders!.where((o) => ( 0 == o.state.toLowerCase().compareTo(ListElement.orderCategoryTitle[position].toLowerCase()))).toList().length;  
    }
    return 0;
  }

  Future<int> dashboardCount(int position) async{
    switch (position){
      case 0:{
        return await analytic.getUserCount();
      } 
      case 1:{
        return await analytic.getProductsCount();
      }
      case 2:{
        return await analytic.getOrdersCount();
      }
    }
    return 0;
  }
}