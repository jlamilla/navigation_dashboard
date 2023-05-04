import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/domain/models/favorite/favorite_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

enum SearchTitle{
  dashboard(title: 'Buscar en las estadisticas'),
  products(title: 'Buscar prenda'),
  users(title: 'Buscar usuario'),
  orders(title: 'Buscar pedido'),
  site(title: 'Buscar ubicación de la prenda por Referencia');

  const SearchTitle({
    required this.title,
  });

  final String title;
}

final searchNotifierProvider = StateNotifierProvider.autoDispose.family((ref, List<dynamic> data) {
  final String search = ref.watch(searchProvider);
  final int index = ref.watch(drawerIndexProvider);
  final String searchCategory;
  if(index == 1){
    searchCategory = ref.watch(searchProductsCategoryProvider);
  }else if(index == 5){
    searchCategory = ref.watch(searchUsersCategoryProvider);
  }else{
    searchCategory = ref.watch(searchOrdersCategoryProvider);
  }
  return SearchNotifier( data, search: search, searchCategory: searchCategory);
});

final searchProvider = StateProvider.autoDispose<String>((ref) => '');
final searchProductsCategoryProvider = StateProvider.autoDispose<String>((ref) => Strings.allStates);
final searchUsersCategoryProvider = StateProvider.autoDispose<String>((ref) => Strings.allStates);
final searchOrdersCategoryProvider = StateProvider.autoDispose<String>((ref) => Strings.allStates);

class SearchNotifier extends StateNotifier<List<dynamic>>{

  SearchNotifier( super.state, {required this.search, required this.searchCategory,} );
  final String search;
  final String searchCategory;

  List<User> filterUser() {
    List<User> users = state.cast<User>();

    //Filter by user data
    if(search.isNotEmpty){
        users = users.where((u) => 
                    u.name.toLowerCase().contains(search.toLowerCase()) ||
                    u.lastname.toLowerCase().contains(search.toLowerCase()) ||
                    ('${u.name} ${u.lastname}').toLowerCase().contains(search.toLowerCase()) ||
                    u.dni.contains(search) ||
                    u.rol.toLowerCase().contains(search.toLowerCase()) ||
                    u.email.contains(search)
                    ).toList();
                    //(searchCategory != Strings.allStates)
    }

    //Filter by user category
    if(searchCategory.isNotEmpty && searchCategory != Strings.allStates){
      users = users.where((u) => 
                    0 == u.state.toLowerCase().compareTo(searchCategory.toLowerCase())
                  ).toList();
    }

    return users;
  }
  
  List<Product> filterProduct() {

    List<Product> products = state.cast<Product>();

    //Filter by product data
    if(search.isNotEmpty){
        products = products.where((p) => 
                    p.name.toLowerCase().contains(search.toLowerCase()) ||
                    p.reference.contains(search) ||
                    (p.reference+p.pinta).toLowerCase().contains(search.toLowerCase()) ||
                    p.pinta.toLowerCase().contains(search) ||
                    Formatter.priceFormat(p.price).contains(search) ||
                    p.price.contains(search)
                  ).toList();
    }
    //Filter by product category
    if(searchCategory.isNotEmpty && searchCategory != Strings.allStates){
      products = products.where((p) => 
                    0 == p.state.toLowerCase().compareTo(searchCategory.toLowerCase())
                  ).toList();
    }

    return products;
  }

  List<Order> filterOrder() {

    List<Order> orders = state.cast<Order>();

     //Filter by order data
    if(search.isNotEmpty){
        orders = orders.where((o) => 
                    o.fullname.toLowerCase().contains(search.toLowerCase()) ||
                    o.dateCreate.toString().contains(search) ||
                    o.dateUpdate.toString().contains(search) ||
                    o.dni.contains(search) ||
                    o.amountProduct.toString().contains(search) ||
                    Formatter.priceFormat(o.total).contains(search) ||
                    o.total.contains(search)).toList();
    }
    //Filter by order category
    if(searchCategory.isNotEmpty && searchCategory != Strings.allStates){
        orders = orders.where((o) => o.state.toLowerCase().contains(searchCategory.toLowerCase())).toList();
    }

    return orders;
  }
  
  List<Product> filterFavoriteCategory(List<Product> products, List <Favorite> itemFavorite) {
    List<Product> result = [];

    if(itemFavorite.isNotEmpty){
      for(int i = 0 ; i < products.length ; i++){
      if(itemFavorite[i].reference == products[i].reference){
        result.add(products[i]);
      }
      }
    }
    return result;
  }

  List<Order> filterSeller(List<Order> orders, User userProfile) {

    return orders.where((o) => o.dni.toLowerCase().contains(userProfile.dni.toLowerCase())).toList();
  
  }
}
