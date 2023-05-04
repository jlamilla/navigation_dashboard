import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';

class DashBoardScreen extends StatelessWidget {
  
  const DashBoardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (_, WidgetRef ref, __) => ref.watch(drawerProvider)
        ),
      )
    );
  }
}
