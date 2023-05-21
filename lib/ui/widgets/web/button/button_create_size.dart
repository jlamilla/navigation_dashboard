import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/product_size_provider.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

class ButtonCreateSize extends ConsumerWidget {
  const ButtonCreateSize({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.green.light),
          padding: ButtonState.all(const EdgeInsets.symmetric(vertical:18, horizontal: 80)),
          textStyle: ButtonState.all(const TextStyle(fontSize: 17)),
        ),
        onPressed: (){
            final Map<String, TextEditingController> size = { "size": TextEditingController(), "amount": TextEditingController(),};
            ref.read(productSizeControllerProvider.notifier).update((state) => state = [size,...state]);
            ref.read(productSizeSelectIndexProvider.notifier).state.clear();
          },
        child: const Text(Strings.addProductSize),
      ),
    );
  }
}