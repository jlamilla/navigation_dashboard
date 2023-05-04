import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_dashboard/config/providers/product_provider.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/image_custom/image_custom.dart';
import 'package:navigation_design/tokens/colors.dart';



class ProductUpdatePage extends StatelessWidget {
  
  const ProductUpdatePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final formProductAddKey = GlobalKey<FormState>();
    return Form(
          key: formProductAddKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsUpdate(formProductAddKey: formProductAddKey),
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
                      child: const ButtonCreateProductSize(),
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
                      child: const ButtonDeleteProductSize(),
                    ),
                  ]
                ),
              );
  }
}

class ProductDetailsUpdate extends ConsumerWidget {
  
  const ProductDetailsUpdate({Key? key, required this.formProductAddKey}) : super(key: key);
  final GlobalKey<FormState> formProductAddKey;
  
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
                  child: ImageCustom()
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
                                      Clipboard.setData(ClipboardData(text: ref.watch(referenceProductProvider)));
                                  }
                          ),
                          initialValue: 'Ref. ${ref.watch(referenceProductProvider)}',
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
                          initialValue:  ref.watch(nameProductProvider),
                          onChanged: (value) => ref.read(nameProductProvider.notifier).update((state) => state = value),
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
                          suffix: IconButton(
                                icon: const Icon(
                                  FluentIcons.copy, 
                                  size: 20, 
                                  color: grey,
                                ), 
                                  onPressed: (){
                                      Clipboard.setData(ClipboardData(text: ref.watch(referenceProductProvider)));
                                  }
                          ),
                          initialValue: ref.watch(pintaProductProvider),
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
                          initialValue:  ref.watch(pintaDescriptionProductProvider),
                          onChanged: (value) => ref.read(pintaDescriptionProductProvider.notifier).update((state) => state = value),
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
                          initialValue:  ref.watch(priceProductProvider),
                          onChanged: (value) => ref.read(priceProductProvider.notifier).update((state) => state = value),
                          autocorrect: false,
                          validator: (value) => Validations.validateNoEmpty(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: AutoSuggestBox<ProductSites>.form(
                          controller: ref.watch(siteProductProvider),
                          autovalidateMode : AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 18
                          ),
                          validator: (value) => Validations.validateSelectProductSize(value),
                          placeholder: Fields.site,
                          items: ListElement.productSite.map((site) {
                            return AutoSuggestBoxItem<ProductSites>(
                              value: site,
                              label:  site.name,
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
                          initialValue: ref.watch(descriptionProductProvider),
                          onChanged: (value) => ref.read(descriptionProductProvider.notifier).update((state) => state = value),
                          maxLength: 200,
                          maxLines: null,
                          validator: (value) => Validations.validateNoEmptyString(value),
                        ),
                      ),
                      ButtonUpdateProduct(formProductAddKey: formProductAddKey),
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

class ButtonUpdateProduct extends ConsumerWidget {
  const ButtonUpdateProduct({super.key, required this.formProductAddKey});
  final GlobalKey<FormState> formProductAddKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    final idProduct = '${ref.watch(referenceProductProvider)}${ref.watch(pintaProductProvider)}';
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
                      onPressed: isLoading 
                                ? null 
                                : () async{
                                  ref.read(loadingProvider.notifier).update((state) => !state);
                                  if(formProductAddKey.currentState!.validate()){
                                    if(await ref.read(productProvider.notifier).updateProduct(ref.read(photoProvider), ref.read(productSizeControllerProvider))){
                                      if(context.mounted){
                                        ref.read(drawerIndexProvider.notifier).update((state) => state = 1,);
                                        displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                                          return InfoBar(
                                            title: const Text(Strings.successAlert),
                                            content: Text('${Strings.successProductContent} $idProduct ${Strings.successUpdateContent}'),
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
                                            content: Text('${Strings.successProductContent} $idProduct no ${Strings.successUpdateContent}'),
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
                      child: isLoading 
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const[
                          ProgressRing(backgroundColor:  white, activeColor: secondaryColor),
                          SizedBox(width: 24,),
                          Text('Actualizando prenda...')
                        ],
                      )
                      : const Text(Strings.updateProduct)
                    ),
            ),
          ),
        ],
      );
  }
}

class ButtonCreateProductSize extends ConsumerWidget {
  const ButtonCreateProductSize({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productSizesProvider = ref.watch(productSizeControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.green.light),
          padding: ButtonState.all(const EdgeInsets.symmetric(vertical:18, horizontal: 80)),
          textStyle: ButtonState.all(const TextStyle(fontSize: 17)),
        ),
        onPressed: productSizesProvider.length == 9
          ? () => displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close) {
              return InfoBar(
                title: const Text(Strings.helpAlert),
                content: const Text(Strings.helpProductSizeMaxContent),
                action: IconButton(
                  icon: const Icon(FluentIcons.clear),
                  onPressed: close,
                ),
                severity: InfoBarSeverity.info,
              );
          })
          : (){
            final Map<String, TextEditingController> size = { "size": TextEditingController(), "amount": TextEditingController(),};
            ref.read(productSizeControllerProvider.notifier).update((state) => state = [size,...state]);
            ref.read(productSizeSelectIndexProvider.notifier).state.clear();
          },
        child: const Text(Strings.addProductSize),
      ),
    );
  }
}

class ButtonDeleteProductSize extends ConsumerWidget{
  const ButtonDeleteProductSize({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: ButtonState.all(Colors.red.light),
                  padding:  ButtonState.all(const EdgeInsets.symmetric(vertical:18, horizontal: 73)),
                  textStyle: ButtonState.all(const TextStyle(fontSize: 17)),
                ),
                child: const Text(Strings.delateProductSize),
                onPressed: ()async{
                      final productSizesSelect = ref.read(productSizeSelectIndexProvider);
                      final productSizes = ref.read(productSizeControllerProvider);
                      final validate = await showDialog<bool>(
                        context: context,
                        builder: (context) => ContentDialog(
                          title: const Text(Strings.deleteTitle),
                          content: const Text(Strings.deleteProductSizeContent),
                          actions: [
                            Button(
                              onPressed: () {
                                bool validate = false;
                                var temp = productSizes;
                                for(var index in productSizesSelect){
                                  temp = temp.where((element) => element != productSizes[index]).toList();
                                    //temp.removeWhere((element) => productSizes[index] == element);
                                  validate = true;
                                }
                                ref.read(productSizeControllerProvider.notifier).update((state) => state = temp);
                                productSizesSelect.clear();
                                return Navigator.pop(context, validate);
                              },
                              child: const Text(Strings.buttonDelete)
                            ),
                            FilledButton(
                              child: const Text(Strings.buttonCancel),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                          ],
                        ),
                      ) ?? false;
                      if(validate && context.mounted){
                        displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close) {
                          return InfoBar(
                            title: const Text(Strings.successAlert),
                            content: const Text(Strings.successDeleteProductSizeAlert),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.success,
                          );      
                        });
                      }else {
                        displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close) {
                          return InfoBar(
                            title: const Text(Strings.warningAlert),
                            content: const Text(Strings.errorDeleteProductSizeAlert),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.warning,
                          );      
                        });
                      }
                },
              ),
    );  
  }
}