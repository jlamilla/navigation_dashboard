import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/product_provider.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/alerts.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';
import 'package:navigation_dashboard/ui/widgets/web/grid_view/grid_view_data.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductsPage extends StatelessWidget {
  
  const ProductsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
            mobile: ProductFuture(
              crossAxisCount: AppScreen.getWidthSize < 650 ? 1 : 2,
              childAspectRatio: AppScreen.getWidthSize < 650 ? 1 : 1,
            ),
            tablet: const ProductFuture(),
            desktop: ProductFuture(
              crossAxisCount: AppScreen.getWidthSize < 1400 ? 3 : 4,
            ),
        );
  }
}

class ProductFuture extends ConsumerWidget {
  const ProductFuture({super.key, this.crossAxisCount = 3, this.childAspectRatio = 0.55,});

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
    final userRole = ref.watch(authProvider.notifier).userProfile.rol;
    final validateRole = userRole.compareTo(Roles.admin) == 0;
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
          ProductCardContentInfo(productInfo: productInfo, validateRole: validateRole),
          Visibility(
            visible: validateRole,
            child: CardButtons( 
              onPressedButtonEdit: () async{
                ref.watch(photoURLProvider.notifier).update((state) => state = productInfo.photoURL);
                ref.watch(productDetailsProvider.notifier).update((state) => state = productInfo);
                final controller = await ref.watch(productSizesFutureProvider(productInfo.id!).future);
                ref.watch(productSizeControllerProvider.notifier).update((state) => state = controller);
                ref.watch(drawerIndexProvider.notifier).update((state) => state = DrawerIndex.adminIndex.productUpdate);
              },
              onPressedButtonDelete: () async{
                final validate = await AlertCustom().showContentDialog(
                  title: Strings.deleteTitleProduct, 
                  content: Strings.deleteContentProduct,
                  context: context, 
                  action: () async{
                    return Navigator.pop(context, await ref.read(productProvider.notifier).deleteProduct(productInfo));
                  }, 
                );
                if(validate && context.mounted){
                  ref.watch(drawerIndexProvider.notifier).update((state) => state = DrawerIndex.adminIndex.dashboard);
                  displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                    return InfoBar(
                      title: const Text(Strings.successAlert),
                      content: Text('${Strings.successProductContent} ${productInfo.id} ${Strings.successDeleteContent}'),
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
                      content: Text('${Strings.successProductContent} ${productInfo.id} no ${Strings.successDeleteContent}'),
                      action: IconButton(
                        icon: const Icon(FluentIcons.clear),
                        onPressed: close,
                      ),
                      severity: InfoBarSeverity.error,
                    );
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductCardImage extends ConsumerWidget {
  
  const ProductCardImage({Key? key, required this.productInfo}) : super(key: key);

  final Product productInfo;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: () async{
          ref.watch(photoURLProvider.notifier).update((state) => state = productInfo.photoURL);
          ref.watch(productDetailsProvider.notifier).update((state) => state = productInfo);
          final controller = await ref.watch(productSizesFutureProvider(productInfo.id!).future);
          ref.watch(productSizeControllerProvider.notifier).update((state) => state = controller);
          final drawer = ref.watch(drawerIndexTypeProvider);
          ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.productDetails);
        },
        child: Container(
          child: productInfo.photoURL.isEmpty 
                ? const OurAssetImage( 
                  assetName: Images.noPhoto, 
                  placeholder: Images.loading,
                )
                : OurNetworkImage(url: productInfo.photoURL, placeholder: Images.loading,),
        ),
      ),
    );
  }
}

class ProductCardContentInfo extends StatelessWidget {
  const ProductCardContentInfo({ super.key, required this.productInfo, required this.validateRole});

  final Product productInfo;
  final bool validateRole;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ref. ${productInfo.id}', style: const TextStyle( fontSize: 18, fontWeight: FontWeight.w600)),
          Text('${productInfo.name} ${productInfo.pintaDescription.toLowerCase()}', style: const TextStyle( fontSize: 15, fontWeight: FontWeight.w400)),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: Divider(
                style: DividerThemeData(
                  thickness: 1,
                  decoration: BoxDecoration(
                    color: primaryColor
                  )
                ),            
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.p_b_i_anomalies_marker, color: grey, size: 20),
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
                const Icon(FluentIcons.info, color: grey, size: 20,),
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
                const Icon(FluentIcons.circle_dollar, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(Formatter.priceFormat(productInfo.price)),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.update_restore, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(productInfo.productUpdateDate),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          validateRole ?
          const SizedBox(height: 20,)
          : Padding(
            padding: const EdgeInsets.only(left: 30,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.circle_addition, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(productInfo.productCreateDate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}