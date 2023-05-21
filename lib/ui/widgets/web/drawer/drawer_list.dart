import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/pages/home/components/dashboard_content_screen.dart';
import 'package:navigation_dashboard/ui/pages/orders/components/order_details_page.dart';
import 'package:navigation_dashboard/ui/pages/orders/orders_page.dart';
import 'package:navigation_dashboard/ui/pages/products/components/product_create_page.dart';
import 'package:navigation_dashboard/ui/pages/products/components/product_details_page.dart';
import 'package:navigation_dashboard/ui/pages/products/components/product_update_page.dart';
import 'package:navigation_dashboard/ui/pages/products/products_page.dart';
import 'package:navigation_dashboard/ui/pages/tutorials.dart';
import 'package:navigation_dashboard/ui/pages/users/components/user_create_page.dart';
import 'package:navigation_dashboard/ui/pages/users/components/user_details_page.dart';
import 'package:navigation_dashboard/ui/pages/users/components/user_update_page.dart';
import 'package:navigation_dashboard/ui/pages/users/users_page.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_menu.dart';

class DrawerList{

  static List<NavigationPaneItem> itemsAdmin = [
            PaneItem(
              title: const Text(Strings.dashboard, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.analytics_view), 
              body: const NavigationBodyItem(
                      header: Strings.dashboard,
                      content: DashboardContentScreen(),
                    ),
            ),
            PaneItemSeparator(),
            PaneItemExpander(
              title: const Text(Strings.products, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.shirt), 
              body: const NavigationBodyItem(
                      header: Strings.products,
                      searchTitle: Strings.searchProduct,
                      searchMessage: Strings.searchMessageProduct,
                      content: ProductsPage(),
                    ),
              items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.add),
                    title: const Text(Strings.addProduct),
                    body: const NavigationBodyItem(
                      header: Strings.addProduct,
                      content: ProductCreatePage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.edit),
                    title: const Text(Strings.updateProduct),
                    body: const NavigationBodyItem(
                      header: Strings.updateProduct,
                      content: ProductUpdatePage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.info),
                    title: const Text(Strings.detailsProduct),
                    body: const NavigationBodyItem(
                      header: Strings.detailsProduct,
                      content: ProductDetailsPage(),
                    ),
                  )
                ],
            ),
            PaneItemExpander(
              title: const Text(Strings.users, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.contact), 
              body: const NavigationBodyItem(
                        header: Strings.users,
                        searchTitle: Strings.searchUser,
                        searchMessage: Strings.searchMessageUser,
                        content: UsersPage(),
                    ),
              items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.add_friend),
                    title: const Text(Strings.createUser),
                    body: const NavigationBodyItem(
                      header: Strings.createUser,
                      content: UserCreatePage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.edit_contact),
                    title: const Text(Strings.updateUser),
                    body: const NavigationBodyItem(
                      header: Strings.updateUser,
                      content: UserUpdatePage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.contact_info),
                    title: const Text(Strings.detailsUser),
                    body: const NavigationBodyItem(
                      header: Strings.detailsUser,
                      content: UserDetailPage(),
                    ),
                  ),
                ],
            ),
            PaneItemExpander(
              title: const Text(Strings.orders, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.clipboard_list_mirrored), 
              body: const NavigationBodyItem(
                        header: Strings.orders,
                        searchTitle: Strings.searchOrder,
                        searchMessage: Strings.searchMessageOrder,
                        content: OrdersPage(),
                    ),
              items: [
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.info),
                    title: const Text(Strings.orderDetails),
                    body: const NavigationBodyItem(
                      header: Strings.orderDetails,
                      content: OrderDetailsPage(),
                    ),
                  ),
                ],
            ),
            PaneItemSeparator(),
            PaneItem(
              title: const Text(Strings.tutorial, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.contact), 
              body: const NavigationBodyItem(
                      header: Strings.tutorial,
                      content: TutorialsPage(),
                    ),
            ),
          ];
  static List<NavigationPaneItem> itemsCommercial = [
            PaneItemExpander(
              title: const Text(Strings.products, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.shirt), 
              body: const NavigationBodyItem(
                      header: Strings.products,
                      searchTitle: Strings.searchProduct,
                      searchMessage: Strings.searchMessageProduct,
                      content: ProductsPage(),
                    ),
              items: [
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.info),
                    title: const Text(Strings.detailsProduct),
                    body: const NavigationBodyItem(
                      header: Strings.detailsProduct,
                      content: ProductDetailsPage(),
                    ),
                  )
                ],
            ),
            PaneItemExpander(
              title: const Text(Strings.users, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.contact), 
              body: const NavigationBodyItem(
                        header: Strings.users,
                        searchTitle: Strings.searchUser,
                        searchMessage: Strings.searchMessageUser,
                        content: UsersPage(),
                    ),
              items: [
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.edit_contact),
                    title: const Text(Strings.updateUser),
                    body: const NavigationBodyItem(
                      header: Strings.updateUser,
                      content: UserUpdatePage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.contact_info),
                    title: const Text(Strings.detailsUser),
                    body: const NavigationBodyItem(
                      header: Strings.detailsUser,
                      content: UserDetailPage(),
                    ),
                  ),
                ],
            ),
            PaneItemExpander(
              title: const Text(Strings.orders, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.clipboard_list_mirrored), 
              body: const NavigationBodyItem(
                        header: Strings.orders,
                        searchTitle: Strings.searchOrder,
                        searchMessage: Strings.searchMessageOrder,
                        content: OrdersPage(),
                    ),
              items: [
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.info),
                    title: const Text(Strings.orderDetails),
                    body: const NavigationBodyItem(
                      header: Strings.orderDetails,
                      content: OrderDetailsPage(),
                    ),
                  ),
                ],
            ),
            PaneItemSeparator(),
            PaneItem(
              title: const Text(Strings.tutorial, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.contact), 
              body: const NavigationBodyItem(
                      header: Strings.tutorial,
                      content: TutorialsPage(),
                    ),
            ),
          ];
  
}

enum DrawerIndex{
  adminIndex(
    dashboard: 0,
    products: 1,
    productCreate: 2,
    productUpdate: 3,
    productDetails: 4,
    users: 5,
    userCreate: 6,
    userUpdate: 7,
    userDetails: 8,
    orders: 9,
    orderDetails: 10,
    tutorials: 11,
  ),
  commercialIndex(
    dashboard: null,
    products: 0,
    productCreate: null,
    productUpdate: null,
    productDetails: 1,
    users: 2,
    userCreate: null,
    userUpdate: 3,
    userDetails: 4,
    orders: 5,
    orderDetails: 6,
    tutorials: 7,
  );

  const DrawerIndex({
      required this.dashboard,
      required this.products,
      required this.productCreate,
      required this.productUpdate,
      required this.productDetails,
      required this.users,
      required this.userCreate,
      required this.userUpdate,
      required this.userDetails,
      required this.orders,
      required this.orderDetails,
      required this.tutorials,
  });

  final int? dashboard;
  final int products;
  final int? productCreate;
  final int? productUpdate;
  final int productDetails;
  final int users;
  final int? userCreate;
  final int userUpdate;
  final int userDetails;
  final int orders;
  final int orderDetails;
  final int tutorials;
}