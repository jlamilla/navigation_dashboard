import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/product_provider.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/config/routers/app_navigator.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/pages/web/products/components/product_update_page.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/grid_view/grid_view_data.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductsPage extends StatelessWidget {
  
  const ProductsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
            mobile: ProductStream(
              crossAxisCount: AppScreen.getWidthSize < 650 ? 1 : 2,
              childAspectRatio: AppScreen.getWidthSize < 650 ? 1 : 1,
            ),
            tablet: const ProductStream(),
            desktop: ProductStream(
              crossAxisCount: AppScreen.getWidthSize < 1400 ? 3 : 4,
            ),
        );
  }
}

class ProductStream extends ConsumerWidget {
  const ProductStream({super.key, this.crossAxisCount = 3, this.childAspectRatio = 0.55,});

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.watch(productsFutureProvider);
    return productData.when(
      data: (products){
        return  Consumer(
          builder: (_, WidgetRef ref, __) { 
            final productsFilter = ref.watch(searchNotifierProvider(products).notifier).filterProduct();
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: CardCategory(data: products)
                ),
                Expanded(
                  flex: 5,
                  child: GridViewData(
                    crossAxisCount: crossAxisCount, 
                    childAspectRatio: childAspectRatio,
                    products: productsFilter,
                    itemCount: productsFilter.length,
                  )
                ),
              ],
            );
          },
        );
      },
      error: (error, stackTrace) => const H2(text: 'No hay prendas registradas'),
      loading: () => UserGridViewSkelton(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, itemCount: 4)
    );
  }
}

class ProductCard extends ConsumerWidget {
  
  const ProductCard({Key? key, required this.productInfo, required int index}) : super(key: key);

  final Product productInfo;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow( color: boxShadow1, blurRadius: 10, offset: const Offset(0, 5) )],
      ),
      child: Column(
        children: [
          ProductCardImage(productInfo: productInfo),
          ProductCardContentInfo(productInfo: productInfo),
          CardButtons( 
            onPressedButtonEdit: () async{
              ref.watch(photoProvider.notifier).photoURL = productInfo.photoURL;
              ref.watch(photoPathProductProvider.notifier).update((state) => state = productInfo.photoPath);
              ref.watch(photoURLProductProvider.notifier).update((state) => state = productInfo.photoURL);
              ref.watch(referenceProductProvider.notifier).update((state) => state = productInfo.reference);
              ref.watch(nameProductProvider.notifier).update((state) => state = productInfo.name);
              ref.watch(descriptionProductProvider.notifier).update((state) => state = productInfo.description);
              ref.watch(pintaProductProvider.notifier).update((state) => state = productInfo.pinta);
              ref.watch(pintaDescriptionProductProvider.notifier).update((state) => state = productInfo.pintaDescription);
              ref.watch(priceProductProvider.notifier).update((state) => state = productInfo.price);
              ref.watch(siteProductProvider.notifier).update((state) {
                TextEditingController site = TextEditingController();
                site.text = '${Strings.siteProduct} ${productInfo.site}';
                return site;
              });
              final controller = await ref.watch(productSizesFutureProvider(productInfo.id!).future);
              ref.watch(productSizeControllerProvider.notifier).update((state) => state = controller);
              ref.watch(createDateProductProvider.notifier).update((state) => state = productInfo.productCreateDate);
              ref.watch(drawerIndexProvider.notifier).update((state) => state = 3);
            },
            onPressedButtonDelete: () {

              ref.watch(drawerIndexProvider.notifier).update((state) => state = 1);
            },
          )
        ],
      ),
    );
  }
}

class ProductCardImage extends StatelessWidget {
  
  const ProductCardImage({Key? key, required this.productInfo}) : super(key: key);

  final Product productInfo;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          //CardImageBackground(state: userInfo.state),
          Container(
            child: productInfo.photoURL.isEmpty 
                  ? const OurAssetImage( 
                    assetName: Images.noPhoto, 
                    placeholder: Images.loading,
                  )
                  : OurNetworkImage(url: productInfo.photoURL, placeholder: Images.loading,),
          ),
        ]
      ),
    );
  }
}

class ProductCardContentInfo extends StatelessWidget {
  const ProductCardContentInfo({ super.key, required this.productInfo,});

  final Product productInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          Text('Ref. ${productInfo.id}', style: const TextStyle( fontSize: 18, fontWeight: FontWeight.w600)),
          Text('${productInfo.name} ${productInfo.pintaDescription.toLowerCase()}', style: const TextStyle( fontSize: 15, fontWeight: FontWeight.w400)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 1,
              color: primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: grey, size: 20),
                const SizedBox(width: 5,),
                Text('${Strings.siteProduct} ${productInfo.site}'),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.access_time_filled_rounded, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(productInfo.state),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.monetization_on_rounded, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(Formatter.priceFormat(productInfo.price)),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.update_rounded, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(productInfo.productUpdateDate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}