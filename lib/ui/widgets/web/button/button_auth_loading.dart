import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_design/tokens/colors.dart';

class ButtonAuthLoading extends ConsumerWidget {
  const ButtonAuthLoading({super.key, required this.title , required this.loading, required this.action,});
  final Function()? action;
  final String title;
  final String loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: 250,
              height: 60,
              child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: ButtonState.all(Colors.black),
                        padding: ButtonState.all(const EdgeInsets.all(20)),
                        textStyle: ButtonState.all(const TextStyle(fontSize: 18)),
                        shape: ButtonState.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                        )
                      ),
                      onPressed: isLoading 
                                ? null 
                                : action,
                      child: isLoading 
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 30,
                            child: ProgressRing(backgroundColor:  white, activeColor: buttonG,)
                          ),
                          const SizedBox(width: 20,),
                          Text(loading)
                        ],
                      )
                      : Text(title)
                    ),
            ),
          ),
        ],
      );
  }
}