import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/card_provider.dart';
import 'package:navigation_dashboard/config/providers/order_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image.dart';
import 'package:navigation_dashboard/ui/widgets/web/grid_view/grid_view_data.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';

class OrdersPage extends StatelessWidget {
  
  const OrdersPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
            mobile: OrdersStream(
              crossAxisCount: AppScreen.getWidthSize < 650 ? 1 : 2,
              childAspectRatio: AppScreen.getWidthSize < 650 ? 0.9 : 0.6,
              
            ),
            tablet: const OrdersStream(),
            desktop: OrdersStream(
              crossAxisCount: AppScreen.getWidthSize < 1400 ? 3 : 4,
              childAspectRatio: AppScreen.getWidthSize < 1400 ? 0.5 : AppScreen.getWidthSize < 1522 ? 0.5 : 0.6 ,
            ),
        );
  }
}

class OrdersStream extends ConsumerWidget {
  const OrdersStream({super.key, this.crossAxisCount = 3, this.childAspectRatio = 0.5,});

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersData = ref.watch(orderStreamProvider);
    return ordersData.when(
      data: (orders){
        return  Consumer(
          builder: (_, WidgetRef ref, __) { 
            final ordersFilter = ref.watch(searchNotifierProvider(orders).notifier).filterOrder();
            ref.watch(cardOrderProvider.notifier).cardOrder(ordersFilter);
            return Column(
            children: [
                Expanded(
                  flex: 1,
                  child: CardCategory(data: orders)
                ),
                Expanded(
                  flex: 5,
                  child: GridViewData(
                    crossAxisCount: crossAxisCount, 
                    childAspectRatio: childAspectRatio,
                    orders: ordersFilter,
                    itemCount: ordersFilter.length,
                  )
                ),
              ],
            );
          },
        );
      },
      error: (error, stackTrace) => const H2(text: 'No hay ordenes registradas'),
      loading: () => UserGridViewSkelton(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, itemCount: 4)
    );
  }
}

class OrderCard extends StatelessWidget {
  
  const OrderCard({Key? key, required this.orderInfo, required  this.cardInfo}) : super(key: key);

  final Order orderInfo;
  final AnalyticData cardInfo;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow( color: boxShadow1, blurRadius: 10, offset: const Offset(0, 5) )],
      ),
      child: Column(
        children: [
          CardImage(cardInfo: cardInfo,),
          OrderCardContentInfo(orderInfo: orderInfo),
          CardButtons( 
            onPressedButtonEdit: (){

            },
            onPressedButtonDelete: () {
              
            },
          )
        ],
      ),
    );
  }
}

class OrderCardContentInfo extends StatelessWidget {
  const OrderCardContentInfo({ super.key, required this.orderInfo,});

  final Order orderInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          Text('C.C. ${orderInfo.dni}', style: const TextStyle( fontSize: 18, fontWeight: FontWeight.w600)),
          Text(orderInfo.fullname, style: const TextStyle( fontSize: 15, fontWeight: FontWeight.w400)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              style: DividerThemeData(
                thickness: 1,
                decoration: BoxDecoration(
                  color: primaryColor
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.clipboard_list, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text('Unidades: ${orderInfo.amountProduct}'),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.money, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text('Precio total: ${Formatter.priceFormat(orderInfo.total)}'),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.add_event, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(orderInfo.dateCreate),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.calendar_reply, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(orderInfo.dateUpdate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}