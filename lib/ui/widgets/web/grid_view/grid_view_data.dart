import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/card_provider.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/ui/pages/web/orders/orders_page.dart';
import 'package:navigation_dashboard/ui/pages/web/products/products_page.dart';
import 'package:navigation_dashboard/ui/pages/web/users/users_page.dart';

class GridViewData extends ConsumerWidget {
  const GridViewData({
    super.key,
    required this.crossAxisCount,
    required this.childAspectRatio, 
    this.users, 
    this.orders, 
    this.products, 
    required this.itemCount,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final List<User>? users;
  final List<Order>? orders;
  final List<Product>? products;
  final int itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount:  itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: childAspectRatio
      ), 
      itemBuilder: (_, index) {
        return users != null
              ? UserCard(userInfo:users![index], cardInfo: ref.watch(cardUserProvider)[index])
              : orders != null 
              ? OrderCard(orderInfo:orders![index], cardInfo: ref.watch(cardOrderProvider)[index])
              : ProductCard(productInfo:products![index], index: index);
      } 
    );
  }
}