import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/analytic_data_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/image_custom/image_custom.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';



class OrderDetails extends StatelessWidget {
  
  const OrderDetails({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: OrderInfo()
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
        const Expanded(
          child: OrderItems()
        ),
      ],
    );
  }
}

class OrderInfo extends StatelessWidget {
  
  const OrderInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        
        Row(
          children: const[
            Expanded(
              child: ImageCustomCardStateUserOrder(),
            ),
          ],
        ),
        Row(
          children: const[
            TextOrder(
              title: 'Identificación',
              flex: 1,
              value: '1192898698',
            ),
            TextOrder(
              flex: 2,
              title: Fields.name,
              value: 'Jose David Lamilla Acevedo',
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
          children: const[
            TextOrder(
              title: Fields.email,
              value: 'xascue@gmail.com',
            ),
            TextOrder(
              title: Fields.numberPhone,
              value: '314 70 70 577',
            ),
          ],
        ),
        Row(
          children: const [
            TextOrder(
              title: Fields.department,
              value: 'Valle del cauca',
            ),
            TextOrder(
              title: Fields.city,
              value: 'Cali',
            ),
          ],
        ),
        Row(
          children: const[
            TextOrder(
              title: Fields.address,
              value: 'Calle 110 viva 1',
            ),
            TextOrder(
              title: Fields.state,
              value: 'Facturado',
            ),
          ],
        ),
      ],
    );
  }
}

class OrderItems extends StatelessWidget {
  
  const OrderItems({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          children: const[
            TextOrder(
              title: Fields.dateCreate,
              value: '14/04/2023, 05:03:08 AM',
            ),
            TextOrder(
              title: Fields.dateUpdate,
              value: '26/04/2023, 05:03:08 AM',
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) { 
                return const OrderItem();
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
              Text('40 Unidades', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black ,fontSizeFactor: 1.0),),
              Text('\$700.000', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black ,fontSizeFactor: 1.0),),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
  });

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
                                image: 'https://firebasestorage.googleapis.com/v0/b/proyect-4c6f6.appspot.com/o/products%2FPE32912P01%2Ff5c061cb-b452-4ea8-a7bc-b6dd74f72f14.jpg?alt=media&token=e138005a-c272-4421-b426-ac3029f0ec31',
                                placeholder: Images.loading, 
                                fit: BoxFit.fitHeight,
                          ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        child: Text('Ref. PE32912', style: FluentTheme.of(context).typography.subtitle?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 0.9),),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pinta: P01', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                              const SizedBox(height: 5,),
                              Text('Color: Rosado', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Talla: L', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
                              const SizedBox(height: 5,),
                              Text('Precio: \$10.000', style: FluentTheme.of(context).typography.bodyLarge?.apply( color: black.withOpacity(0.8) ,fontSizeFactor: 1.0),),
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
              Text('3 Unidades', style: FluentTheme.of(context).typography.body?.apply( color: black ,fontSizeFactor: 1.0),),
              Text('\$40.000', style: FluentTheme.of(context).typography.body?.apply( color: black ,fontSizeFactor: 1.0),),
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
          label: title,
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
