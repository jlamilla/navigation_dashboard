import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/order_provider.dart';
import 'package:navigation_dashboard/domain/models/order/order_details_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/info_no_select.dart';
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_order.dart';
import 'package:navigation_design/tokens/colors.dart';


class OrderDetailsPage extends ConsumerWidget {
  
  const OrderDetailsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final order = ref.watch(orderSelectProvider);
    final orderItems = ref.watch(orderItemsSelectProvider);
    final drawer = ref.watch(drawerIndexTypeProvider);
    return  order == null
    ?  InfoNoSelect(
      title: Strings.orders,
      content: 'Seleccionar la imagen del pedido que deseas ver a detalle desde :',
      icon: FluentIcons.contact,
      acton: (){
        ref.read(drawerIndexProvider.notifier).update((state) => state = drawer.orders );
      } 
    )
    : Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: OrderInfo(order: order)
        ),
        Divider(
          direction: Axis.vertical,
          size: AppScreen.getHeightSize,
          style: DividerThemeData(
            decoration: BoxDecoration(
              color: grey,
              border: Border.all(width: 1, color: grey)
            )
          ),
        ),
        Expanded(
          child: OrderItems(order: order, orderItems: orderItems,)
        ),
      ],
    );
  }
}

class OrderInfo extends StatelessWidget {
  
  const OrderInfo({Key? key, required this.order}) : super(key: key);
  final Order order;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          children: const[
            Expanded(
              child: ImageCustomOrder(),
            ),
          ],
        ),
        Row(
          children: [
            TextOrder(
              title: Fields.dni,
              flex: 3,
              value: order.dni,
            ),
            TextOrder(
              flex: 5,
              title: Fields.name,
              value: order.fullname,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(
            style: DividerThemeData(
            ),
          ),
        ),
        Row(
          children: [
            TextOrder(
              title: Fields.email,
              value: order.email,
            ),
            TextOrder(
              title: Fields.numberPhone,
              value: order.numberPhone,
            ),
          ],
        ),
        Row(
          children: [
            TextOrder(
              title: Fields.department,
              value: order.department,
            ),
            TextOrder(
              title: Fields.city,
              value: order.city,
            ),
          ],
        ),
        Row(
          children:[
            TextOrder(
              title: Fields.address,
              value: order.address,
            ),
            TextOrder(
              title: Fields.state,
              value: order.state,
            ),
          ],
        ),
      ],
    );
  }
}

class OrderItems extends StatelessWidget {
  
  const OrderItems({Key? key, required this.order, required this.orderItems}) : super(key: key);
  final Order order;
  final List<OrderDetails> orderItems;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          children: [
            TextOrder(
              title: Fields.dateCreate,
              value: order.dateCreate,
            ),
            TextOrder(
              title: Fields.dateUpdate,
              value: order.dateUpdate,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (BuildContext context, int index) { 
                return OrderItem(orderItem: orderItems[index],);
              },
            ),
          ),
        ),
        Divider(
          size: AppScreen.getHeightSize,
          style: DividerThemeData(
            decoration: BoxDecoration(
              color: grey,
              border: Border.all(width: 1, color: grey)
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ', style: FluentTheme.of(context).typography.subtitle?.apply( color: black ,fontSizeFactor: 1.0),),
              Text('${order.amountProduct} ${Fields.units}', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black ,fontSizeFactor: 1.0),),
              Text(Formatter.priceFormat(order.total), style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black ,fontSizeFactor: 1.0),),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({ super.key, required this.orderItem});
  final OrderDetails orderItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Container(
            width: double.infinity,
            height: 136,
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [BoxShadow( color: boxShadow1, blurRadius: 10, offset: const Offset(0, 5) )],
              borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 136,
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                  ),
                  child: FadeInImage.assetNetwork(
                                image: orderItem.photoUrl,
                                placeholder: Images.loading, 
                                fit: BoxFit.fitHeight,
                                imageErrorBuilder: (context, error, stackTrace) => const FadeInImage(placeholder: AssetImage(Images.noPhotoError404), image: AssetImage(Images.noPhotoError404)),
                          ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        child: Text('Ref. ${orderItem.reference}', style: FluentTheme.of(context).typography.subtitle?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 0.9),),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Fields.pinta}: ${orderItem.pinta}', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                              const SizedBox(height: 5,),
                              Text('${Fields.pintaDescription}: ${orderItem.pintaDescription}', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Fields.size}: ${orderItem.size}', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                              const SizedBox(height: 5,),
                              Text('${Fields.price}: ${Formatter.priceFormat(orderItem.price)}', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub total: ', style: FluentTheme.of(context).typography.bodyStrong?.apply( color: black ,fontSizeFactor: 1.0),),
              Text('${orderItem.amount} ${Fields.units}', style: FluentTheme.of(context).typography.body?.apply( color: black ,fontSizeFactor: 1.0),),
              Text(Formatter.priceFormat((int.parse(orderItem.price) * orderItem.amount).toString()), style: FluentTheme.of(context).typography.body?.apply( color: black ,fontSizeFactor: 1.0),),
            ],
          ),
        ),
      ],
    );
  }
}

class TextOrder extends StatelessWidget {
  const TextOrder({
    super.key,
    required this.value, 
    required this.title,
    this.flex
  });

  final String title;
  final String value;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InfoLabel(
          label: '$title :',
          child: TextFormBox(
            readOnly: true,
            suffix: IconButton(
                      icon: const Icon(
                              FluentIcons.copy, 
                              size: 20, 
                              color: grey,
                            ), 
                    onPressed: (){
                        Clipboard.setData(ClipboardData(text: value));
                    }),
            initialValue: value,
            style: TextStyle(
              color: black.withOpacity(0.6),
              height: 1.8,
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
