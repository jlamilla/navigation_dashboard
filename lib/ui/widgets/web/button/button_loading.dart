import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_design/tokens/colors.dart';

class ButtonLoading extends ConsumerWidget {
  const ButtonLoading({super.key, required this.title , required this.loading, required this.action,});
  final Function()? action;
  final String title;
  final String loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
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
                                : action,
                      child: isLoading 
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ProgressRing(backgroundColor:  white, activeColor: secondaryColor),
                          const SizedBox(width: 24,),
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