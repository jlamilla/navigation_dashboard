import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/pages/web/home/components/dashboard_content_screen.dart';
import 'package:navigation_dashboard/ui/pages/web/orders/components/order_update_page.dart';
import 'package:navigation_dashboard/ui/pages/web/orders/orders_page.dart';
import 'package:navigation_dashboard/ui/pages/web/products/components/product_create_page.dart';
import 'package:navigation_dashboard/ui/pages/web/products/components/product_update_page.dart';
import 'package:navigation_dashboard/ui/pages/web/products/products_page.dart';
import 'package:navigation_dashboard/ui/pages/web/tutorials.dart';
import 'package:navigation_dashboard/ui/pages/web/users/components/user_create_page.dart';
import 'package:navigation_dashboard/ui/pages/web/users/users_page.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_menu.dart';

class DrawerList{

  static List<NavigationPaneItem> items = [
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
                      content: ProductUpdatePage(),
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
                      content: UsersPage(),
                    ),
                  ),
                  PaneItem(
                    enabled: false,
                    icon: const Icon(FluentIcons.contact_info),
                    title: const Text(Strings.detailsUser),
                    body: const NavigationBodyItem(
                      header: Strings.detailsUser,
                      content: UsersPage(),
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
                      content: OrderDetails(),
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