import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/product_provider.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_product.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/info_no_select.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductDetailsPage extends ConsumerWidget {
  
  const ProductDetailsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailsProvider);
    return  product == null
    ?  InfoNoSelect(
      title: Strings.products,
      content: 'Seleccionar la imagen de la prenda que deseas ver a detalle desde :',
      icon: FluentIcons.shirt,
      acton: () {
        final drawer = ref.watch(drawerIndexTypeProvider);
        ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.products);
      } 
    )
    : Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductDetails(product: product,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            direction: Axis.vertical,
            size: AppScreen.getHeightSize -150,
            style: DividerThemeData(
              decoration: BoxDecoration(
                color: grey,
                border: Border.all(width: 1, color: grey)
              )
            ),
          ),
        ),
        const ProductSizesDetails()
      ],
    );  
  }
}

class ProductSizesDetails extends ConsumerWidget {
  const ProductSizesDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productSizesProvider = ref.watch(productSizeControllerProvider);
        return Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: productSizesProvider.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 88,
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Text('${index+1}', style: const TextStyle( color: white, height: 1.8, fontSize: 18,), textAlign: TextAlign.center,),
                                ),
                              title: TextProductSizes(value: '${Fields.size}: ${productSizesProvider[index]['size']?.text ?? ''}'),
                              subtitle: TextProductSizes(value: '${Fields.amount}: ${productSizesProvider[index]['amount']?.text ?? ''}' ),
                            );
                        } 
                      ),
                    ),
                  ]
                ),
              );
  }
}

class ProductDetails extends ConsumerWidget {
  
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Row(
              children: [
                const Expanded(
                  child: ImageCustomProduct(action: false,)
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextProductDetails(value: 'Ref. ${product.reference}'),
                      TextProductDetails(value: product.name),
                      TextProductDetails(value: product.pinta),
                      TextProductDetails(value: product.pintaDescription),
                      TextProductDetails(value: Formatter.priceFormat(product.price)),
                      TextProductDetails(value: '${Fields.site} ${product.site}'),
                      TextProductDetailsIcon(value: product.productCreateDate, icon: FluentIcons.circle_addition,),
                      TextProductDetailsIcon(value: product.productUpdateDate, icon: FluentIcons.update_restore,),
                      TextProductDetails(value: product.description),
                  ]
                )
              )
              ],
            ),
          ],
        ),
      ),
    );
  
  }
}

class TextProductSizes extends StatelessWidget {
  const TextProductSizes({
    super.key,
    required this.value
  });
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormBox(
      style: TextStyle(
        height: 1.8,
        fontSize: 18,
        color: black.withOpacity(0.6),
      ),
      readOnly: true,
      initialValue: value,
    );
  }
}

class TextProductDetails extends StatelessWidget {
  const TextProductDetails({
    super.key,
    required this.value
  });
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormBox(
        style: TextStyle(
          height: 1.8,
          fontSize: 18,
          color: black.withOpacity(0.6),
        ),
        readOnly: true,
        suffix: IconButton(
              icon: const Icon(
                FluentIcons.copy, 
                size: 20, 
                color: grey,
              ), 
                onPressed: (){
                    Clipboard.setData(ClipboardData(text: value));
                }
        ),
        initialValue: value,
      ),
    );
  }
}

class TextProductDetailsIcon extends StatelessWidget {
  const TextProductDetailsIcon({
    super.key,
    required this.value,
    required this.icon
  });
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormBox(
        style: TextStyle(
          height: 1.8,
          fontSize: 18,
          color: black.withOpacity(0.6),
        ),
        readOnly: true,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 10, ),
          child: Icon(
                  icon, 
                  size: 20, 
                  color: grey,
                ),
        ),
        suffix: IconButton(
              icon: const Icon(
                FluentIcons.copy, 
                size: 20, 
                color: grey,
              ), 
                onPressed: (){
                    Clipboard.setData(ClipboardData(text: value));
                }
        ),
        initialValue: value,
      ),
    );
  }
}