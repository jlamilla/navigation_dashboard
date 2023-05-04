import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/profile_info.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/search_field.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(drawerIndexProvider);
    return NavigationView(
        appBar: const NavigationAppBar(
          title: Text(Strings.navigation),
        ),
        pane: NavigationPane(
          header: const ProfileInfo(),
          selected: index,
          displayMode: PaneDisplayMode.auto,
          onChanged: (i) => ref.read(drawerIndexProvider.notifier).update((state) => state = i),
          items: DrawerList.items,
          footerItems: [
            PaneItem(
              title: const Text(Strings.settings, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.settings), 
              body: const NavigationBodyItem(
                      header: Strings.settings,
                      content: Text(Strings.settings),
                    ),
            ),
            PaneItemAction(
              title: const Text(Strings.signOut, style: TextStyle(fontSize: 16),), 
              icon: const Icon(FluentIcons.sign_out),
              onTap: () => ref.read(authProvider.notifier).signOut(),
            ),
          ],
        ),
      );
  }
}

class NavigationBodyItem extends StatelessWidget {
  const NavigationBodyItem({
    Key? key,
    this.header,
    this.content, 
    this.searchTitle,
    this.searchMessage,
  }) : super(key: key);

  final String? header;
  final Widget? content;
  final String? searchTitle;
  final String? searchMessage;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: 
          PageHeader(
            title: Text(header ?? 'This is a header text'),
            commandBar: searchTitle != null 
                        ? SearchField(
                          title: searchTitle ?? 'This is a search text', 
                          message: searchMessage ?? 'This is a search message',) 
                        : null,
          ),
      content: content ?? const SizedBox.shrink(),
    );
  }
}