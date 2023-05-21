import 'package:fluent_ui/fluent_ui.dart';
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
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_product.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_loading.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_create_size.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_delete_size.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProductCreatePage extends StatelessWidget {
  
  const ProductCreatePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final formProductAddKey = GlobalKey<FormState>();
    return Form(
          key: formProductAddKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsCreate(formProductAddKey: formProductAddKey),
              Consumer(
                builder: (_, WidgetRef ref, __) { 
                  return Visibility(
                    visible: ref.watch(productSizeContinueProvider),
                      child: Padding(
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
                  );
                },
              ),
              const ProductSizesCreate()
            ],
          ),
        );  
  }
}

class ProductSizesCreate extends ConsumerStatefulWidget {
  const ProductSizesCreate({
    super.key,
  });

  @override
  ProductSizesCreateState createState() => ProductSizesCreateState();
}

class ProductSizesCreateState extends ConsumerState<ProductSizesCreate> {
  @override
  void initState() {
    ref.read(productSizeControllerProvider).clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productSizesProvider = ref.watch(productSizeControllerProvider);
    final productContinueProvider = ref.watch(productSizeContinueProvider);
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Visibility(
            visible: (productSizesProvider.length != 9 && productContinueProvider),
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

class ProductDetailsCreate extends ConsumerStatefulWidget {
  
  const ProductDetailsCreate({Key? key, required this.formProductAddKey}) : super(key: key);
  final GlobalKey<FormState> formProductAddKey;

  @override
  ProductDetailsCreateState createState() => ProductDetailsCreateState();
}

class ProductDetailsCreateState extends ConsumerState<ProductDetailsCreate> {
  late TextEditingController _referenceController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pintaController;
  late TextEditingController _pintaDescriptionController;
  late TextEditingController _priceController;
  late TextEditingController _siteController;

  @override
  void initState() {
    _referenceController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _pintaController = TextEditingController();
    _pintaDescriptionController = TextEditingController();
    _priceController = TextEditingController();
    _siteController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _referenceController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _pintaController.dispose();
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
                  child: ImageCustomProduct(create: true, action: true,)
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormBox(
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.reference,
                          keyboardType: TextInputType.text,
                          controller: _referenceController,
                          validator: (value) => Validations.validateReference(value),
                          inputFormatters: [Formatter.referenceProduct()],
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
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ), 
                          placeholder: Fields.pinta,
                          keyboardType: TextInputType.number, 
                          controller: _pintaController,
                          validator: (value) => Validations.validatePinta(value),
                          inputFormatters: [Formatter.pintaProduct()],
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
                      !ref.watch(productSizeContinueProvider) 
                      ? ButtonContinueProduct(formProductAddKey: widget.formProductAddKey)
                      : ButtonLoading(
                          title: Strings.addProduct,
                          loading: 'Creando prenda...',
                          action: () async{
                            if(widget.formProductAddKey.currentState!.validate()){
                              ref.read(loadingProvider.notifier).update((state) => !state);
                              final product = Product(
                                reference: _referenceController.text, 
                                pinta: _pintaController.text, 
                                pintaDescription: _pintaDescriptionController.text, 
                                name: _nameController.text, 
                                description: _descriptionController.text, 
                                site: _siteController.text, 
                                state: '', 
                                price: _priceController.text, 
                                photoPath: '', 
                                photoURL: '', 
                                productCreateDate: Formatter.dateFormat(), 
                                productUpdateDate: Formatter.dateFormat()
                              );
                              product.id = '${product.reference}${product.pinta}';
                              if(await ref.read(productProvider.notifier).addProduct(ref.read(photoProvider), ref.read(productSizeControllerProvider), product)){
                                if(context.mounted){
                                  ref.read(drawerIndexProvider.notifier).update((state) => state = 1,);
                                  displayInfoBar(context, builder: (context, close) {
                                    return InfoBar(
                                      title: const Text(Strings.successAlert),
                                      content: Text('${Strings.successProductContent} ${product.id} ${Strings.successCreateContent}'),
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
                                      content: Text('${Strings.successProductContent} ${product.id} no ${Strings.successCreateContent}'),
                                      action: IconButton(
                                        icon: const Icon(FluentIcons.clear),
                                        onPressed: close,
                                      ),
                                      severity: InfoBarSeverity.error,
                                    );
                                  });
                                }
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

class ButtonContinueProduct extends ConsumerWidget {
  
  const ButtonContinueProduct({Key? key, required this.formProductAddKey}) : super(key: key);
  final GlobalKey<FormState> formProductAddKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: ButtonState.all(primaryColor),
                padding: ButtonState.all(const EdgeInsets.all(20)),
                textStyle: ButtonState.all(const TextStyle(fontSize: 18)),
              ),
              child: const Text(Strings.next),
              onPressed: (){
                if(formProductAddKey.currentState!.validate()){
                  ref.read(productSizeContinueProvider.notifier).update((state) => !state);
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
              }
            ),
          ),
        ),
      ],
    );
  }
}

