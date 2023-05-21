import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/alerts.dart';

class ButtonDeleteSize extends ConsumerWidget{
  const ButtonDeleteSize({super.key});
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
                      final validate = await AlertCustom().showContentDialog(
                              title: Strings.deleteTitleSize,
                              content: Strings.deleteContentSize,
                              context: context, 
                              action: (){
                                bool validate = false;
                                var temp = productSizes;
                                for(var index in productSizesSelect){
                                  temp = temp.where((element) => element != productSizes[index]).toList();
                                  validate = true;
                                }
                                ref.read(productSizeControllerProvider.notifier).update((state) => state = temp);
                                productSizesSelect.clear();
                                return Navigator.pop(context, validate);
                              }
                            );
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