import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_dashboard/config/providers/product_provider.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/domain/models/product/product_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_product.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/info_no_select.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_create_size.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_delete_size.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_loading.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductUpdatePage extends ConsumerWidget {
  
  const ProductUpdatePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formProductAddKey = GlobalKey<FormState>();
    final product = ref.watch(productDetailsProvider);
    return  product == null
    ? InfoNoSelect(
      title: Strings.products,
      content: 'Seleccionar la prenda a modificar desde :',
      icon: FluentIcons.shirt,
      acton: () => ref.read(drawerIndexProvider.notifier).update((state) => state = DrawerIndex.adminIndex.products ),
    )
    : Form(
          key: formProductAddKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsUpdate(formProductAddKey: formProductAddKey, product: product),
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
              const ProductSizesUpdate()
            ],
          ),
        );  
  }
}

class ProductSizesUpdate extends ConsumerWidget {
  const ProductSizesUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productSizesProvider = ref.watch(productSizeControllerProvider);
        return Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Visibility(
                      visible: (productSizesProvider.length != 9),
                      child: const ButtonCreateSize(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: productSizesProvider.length,
                        itemBuilder: (context, index) {
                          return ListTile.selectable(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Text('${index+1}', style: const TextStyle( color: white, fontSize: 18), textAlign: TextAlign.center,),
                                ),
                              title: TextFormBox(
                                  placeholder: Fields.sizeName, 
                                  keyboardType: TextInputType.visiblePassword, 
                                  controller: productSizesProvider[index]['size'], 
                                  validator:(value) => Validations.validateSize(value), 
                                  inputFormatters: [Formatter.size()],
                              ),
                              subtitle: TextFormBox(
                                  placeholder: Fields.amount, 
                                  keyboardType: TextInputType.number, 
                                  controller: productSizesProvider[index]['amount'],
                                  validator:(value) => Validations.validateAmount(value), 
                                  inputFormatters: [Formatter.amount()],
                              ),
                              selectionMode: ListTileSelectionMode.multiple,
                              selected: ref.watch(productSizeSelectIndexProvider).contains(index),
                              onSelectionChange: (selected) {
                                  if (selected) {
                                    ref.read(productSizeSelectIndexProvider.notifier).update((state) => state = [index,...state]);
                                  }else{
                                    ref.read(productSizeSelectIndexProvider.notifier).update((state) => state = state.where((element) => element != index).toList());
                                  }
                              },
                            );
                        } 
                      ),
                    ),
                    Visibility(
                      visible: productSizesProvider.isNotEmpty,
                      child: const ButtonDeleteSize(),
                    ),
                  ]
                ),
              );
  }
}

class ProductDetailsUpdate extends ConsumerStatefulWidget {
  
  const ProductDetailsUpdate({Key? key, required this.formProductAddKey, required this.product}) : super(key: key);
  final GlobalKey<FormState> formProductAddKey;
  final Product product;

  @override
  ProductDetailsUpdateState createState() => ProductDetailsUpdateState();
}

class ProductDetailsUpdateState extends ConsumerState<ProductDetailsUpdate> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pintaDescriptionController;
  late TextEditingController _priceController;
  late TextEditingController _siteController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _pintaDescriptionController = TextEditingController(text: widget.product.pintaDescription);
    _priceController = TextEditingController(text: widget.product.price);
    _siteController = TextEditingController(text: '${Fields.site} ${widget.product.site}');
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _pintaDescriptionController.dispose();
    _priceController.dispose();
    _siteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Row(
              children: [
                const Expanded(
                  child: ImageCustomProduct(action: true,)
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
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
                                      Clipboard.setData(ClipboardData(text: widget.product.reference));
                                  }
                          ),
                          initialValue: 'Ref. ${widget.product.reference}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.name,
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          validator: (value) => Validations.validateNoEmptyString(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: TextStyle(
                            height: 1.8,
                            fontSize: 18,
                            color: black.withOpacity(0.6),
                          ),
                          readOnly: true,
                          placeholder: Fields.pinta,
                          suffix: IconButton(
                                icon: const Icon(
                                  FluentIcons.copy, 
                                  size: 20, 
                                  color: grey,
                                ), 
                                  onPressed: (){
                                      Clipboard.setData(ClipboardData(text: widget.product.pinta));
                                  }
                          ),
                          initialValue: widget.product.pinta,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.pintaDescription,
                          keyboardType: TextInputType.text,
                          controller: _pintaDescriptionController,
                          validator: (value) => Validations.validateNoEmptyString(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.price,
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          autocorrect: false,
                          validator: (value) => Validations.validateNoEmpty(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: AutoSuggestBox<String>.form(
                          controller: _siteController,
                          autovalidateMode : AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ),
                          validator: (value) => Validations.validateSelectProductSize(value),
                          placeholder: Fields.site,
                          items: ListElement.productSite.map((site) {
                            return AutoSuggestBoxItem<String>(
                              value: site,
                              label: '${Strings.siteProduct} $site',
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.description,
                          keyboardType: TextInputType.text,
                          controller: _descriptionController,
                          maxLength: 200,
                          maxLines: null,
                          validator: (value) => Validations.validateNoEmptyString(value),
                        ),
                      ),
                      ButtonLoading(
                        title: Strings.updateProduct,
                        loading: 'Actualizando prenda...',
                        action: () async{
                          if(widget.formProductAddKey.currentState!.validate()){
                            ref.read(loadingProvider.notifier).update((state) => !state);
                            widget.product.id =  '${widget.product.reference}${widget.product.pinta}'; 
                            widget.product.pintaDescription = _pintaDescriptionController.text;
                            widget.product.name = _nameController.text;
                            widget.product.description = _descriptionController.text;
                            widget.product.site = _siteController.text;
                            widget.product.price = _priceController.text;
                            widget.product.productUpdateDate = Formatter.dateFormat();
                            if(await ref.read(productProvider.notifier).updateProduct(ref.read(photoProvider), ref.read(productSizeControllerProvider), widget.product)){
                              if(context.mounted){
                                ref.read(drawerIndexProvider.notifier).update((state) => state = 1,);
                                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                                  return InfoBar(
                                    title: const Text(Strings.successAlert),
                                    content: Text('${Strings.successProductContent} ${widget.product.id} ${Strings.successUpdateContent}'),
                                    action: IconButton(
                                      icon: const Icon(FluentIcons.clear),
                                      onPressed: close,
                                    ),
                                    severity: InfoBarSeverity.success,
                                  );
                                });
                              }
                            }else if(context.mounted){
                                displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                                  return InfoBar(
                                    title: const Text(Strings.errorAlert),
                                    content: Text('${Strings.successProductContent} ${widget.product.id} no ${Strings.successUpdateContent}'),
                                    action: IconButton(
                                      icon: const Icon(FluentIcons.clear),
                                      onPressed: close,
                                    ),
                                    severity: InfoBarSeverity.error,
                                  );
                                });
                              }
                          }else{
                            displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close) {
                              return InfoBar(
                                title: const Text(Strings.errorAlert),
                                content: const Text(Strings.errorFormContent),
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