import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';

class SearchField extends ConsumerWidget {
  
  const SearchField({Key? key, required this.title, required this.message,}) : super(key: key);
  final String title;
  final String message;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
          width: 240.0,
          child: Tooltip(
            message: message,
            child: TextBox(
              suffix: const Icon(FluentIcons.search),
              placeholder: title,
              onChanged: (value) => ref.read(searchProvider.notifier).update((state) { return state = value;}),
            ),
          ),
    );
  }
}