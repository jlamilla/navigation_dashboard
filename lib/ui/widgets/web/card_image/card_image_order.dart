
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/order_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image_background.dart';
import 'package:navigation_design/atoms/nd_image.dart';

class CardImageOrder extends ConsumerWidget {
  const CardImageOrder({ super.key, required this.cardInfo, required this.order});
  final AnalyticData cardInfo;
  final Order order;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawer = ref.watch(drawerIndexTypeProvider);
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () async{
          ref.watch(orderSelectProvider.notifier).update((state) => order);
          final orderStateColor = CardColorOrderState.values.where((element) => element.state.compareTo(order.state) == 0).toList();
          ref.watch(orderColorState.notifier).update((state) => state = orderStateColor[0] );
          final orderItems = await ref.read(orderDetailsFutureProvider(order.id ?? '').future);
          ref.watch(orderItemsSelectProvider.notifier).update((state) => orderItems);
          ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.orderDetails);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CardImageBackground(color: cardInfo.color,),
            Container(
              padding: const EdgeInsets.only( bottom: 4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: OurAssetImage( 
                          assetName: cardInfo.imageCard!,  
                          placeholder: Images.loading, 
                          widthImage: 130, 
                          heightImage: 130,
                      )   
              ),
            ),
          ]
        ),
      ),
    );
  }
}