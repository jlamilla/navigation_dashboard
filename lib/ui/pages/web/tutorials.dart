import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_design/tokens/colors.dart';

class TutorialsPage extends ConsumerWidget {
  
  const TutorialsPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return Center(
      child: FilledButton(
              style: ButtonStyle(
                backgroundColor: ButtonState.all(primaryColor),
                padding: ButtonState.all(const EdgeInsets.all(20)),
                textStyle: ButtonState.all(const TextStyle(fontSize: 18)),
              ),
              onPressed: isLoading ? null : () async{
                  print('aqui');
                  ref.read(loadingProvider.notifier).update((state) => !state);
                  await Future.delayed(Duration(seconds: 2));
                  ref.read(drawerIndexProvider.notifier).update((state) => state=1);
              },
              child: isLoading 
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  ProgressRing(backgroundColor:  white, activeColor: secondaryColor),
                  SizedBox(width: 24,),
                  Text('Creando prenda...')
                ],
              )
              : const Text(Strings.addProduct)
      ),
    );
  }
}