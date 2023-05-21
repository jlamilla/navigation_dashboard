import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/card_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/order_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/order/order_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/alerts.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image_order.dart';
import 'package:navigation_dashboard/ui/widgets/web/grid_view/grid_view_data.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';

class OrdersPage extends StatelessWidget {
  
  const OrdersPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
            mobile: OrdersFuture(
              crossAxisCount: AppScreen.getWidthSize < 650 ? 1 : 2,
              childAspectRatio: AppScreen.getWidthSize < 650 ? 0.9 : 0.6,
              
            ),
            tablet: const OrdersFuture(),
            desktop: OrdersFuture(
              crossAxisCount: AppScreen.getWidthSize < 1400 ? 3 : 4,
              childAspectRatio: AppScreen.getWidthSize < 1400 ? 0.5 : AppScreen.getWidthSize < 1522 ? 0.5 : 0.6 ,
            ),
        );
  }
}

class OrdersFuture extends ConsumerWidget {
  const OrdersFuture({super.key, this.crossAxisCount = 3, this.childAspectRatio = 0.5,});

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersData = ref.watch(orderFutureProvider);
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

class OrderCard extends ConsumerStatefulWidget {
  
  const OrderCard({Key? key, required this.orderInfo, required  this.cardInfo}) : super(key: key);

  final Order orderInfo;
  final AnalyticData cardInfo;

  @override
  OrderCardState createState() => OrderCardState();
}

class OrderCardState extends ConsumerState<OrderCard> {
  late TextEditingController _stateController;
  @override
  void initState() {
    _stateController = TextEditingController(text: widget.orderInfo.state);
    
    super.initState();
  }
  @override
  void dispose() {
    _stateController.dispose();
    super.dispose();
  }
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
          CardImageOrder(cardInfo: widget.cardInfo, order: widget.orderInfo),
          OrderCardContentInfo(orderInfo: widget.orderInfo),
          CardButtons( 
            onPressedButtonEdit: () async{
              final validate = await AlertCustom().showSelectStateOrderDialog(
                context: context, 
                title: Strings.updateTitleOrder, 
                content: Strings.updateContentOrder, 
                select: ComboBoxOrderState(
                          title: Fields.state,
                          controller: _stateController, 
                        ),
                action: () async{
                  widget.orderInfo.state = _stateController.text;
                  widget.orderInfo.dateUpdate = Formatter.dateFormat();
                  return Navigator.pop(context, await ref.read(orderProvider.notifier).updateOrder(widget.orderInfo));
                }, 
              );
              if(validate && context.mounted){
                ref.read(drawerIndexProvider.notifier).update((state) => state=0);
                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                  return InfoBar(
                    title: const Text(Strings.successAlert),
                    content: Text('${Strings.successOrderContent} ${widget.orderInfo.id} ${Strings.successUpdateContent}'),
                    action: IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: close,
                    ),
                    severity: InfoBarSeverity.success,
                  );
                });    
              }else{
                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                  return InfoBar(
                    title: const Text(Strings.errorAlert),
                    content: Text('${Strings.successOrderContent} ${widget.orderInfo.id} no ${Strings.successDeleteContent}'),
                    action: IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: close,
                    ),
                    severity: InfoBarSeverity.error,
                  );
                });
              }
            },
            onPressedButtonDelete: () async{
              final validate = await AlertCustom().showContentDialog(
                title: Strings.deleteTitleOrder, 
                content: Strings.deleteContentOrder,
                context: context, 
                action: () async{
                  return Navigator.pop(context, await ref.read(orderProvider.notifier).deleteOrder(widget.orderInfo.id!));
                }, 
              );
              if(validate && context.mounted){
                ref.watch(drawerIndexProvider.notifier).update((state) => state = 0);
                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                  return InfoBar(
                    title: const Text(Strings.successAlert),
                    content: Text('${Strings.successOrderContent} ${widget.orderInfo.id} ${Strings.successDeleteContent}'),
                    action: IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: close,
                    ),
                    severity: InfoBarSeverity.success,
                  );
                });    
              }else{
                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                  return InfoBar(
                    title: const Text(Strings.errorAlert),
                    content: Text('${Strings.successOrderContent} ${widget.orderInfo.id} no ${Strings.successDeleteContent}'),
                    action: IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: close,
                    ),
                    severity: InfoBarSeverity.error,
                  );
                });
              }
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
                Text('${Fields.units}: ${orderInfo.amountProduct}'),
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

class ComboBoxOrderState extends ConsumerWidget {
  const ComboBoxOrderState({
    super.key, 
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ComboboxFormField<String>(
      placeholder: Text(title),
      value: controller.text,
      isExpanded: true,
      items: CardColorOrderState.values.map((user) {
            return ComboBoxItem(
              value: user.state,
              child: Text(user.state),
            );
          }).toList(),
      onChanged: (value) {
        if(value != null){
          controller.text = value;
          final orderStateColor = CardColorOrderState.values.where((element) => element.state.compareTo(value) == 0).toList();
          ref.read(orderColorState.notifier).update((state) => state = orderStateColor[0] );
        }
      },
      validator: (value) => Validations.validateSelect(value)
    );
  }
}