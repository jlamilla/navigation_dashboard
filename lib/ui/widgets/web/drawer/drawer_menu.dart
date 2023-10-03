import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/profile_info.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/search_field.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';
import 'package:path_provider/path_provider.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(drawerIndexProvider);
    final user = ref.watch(authProvider.notifier).userProfile;
    final onPressed = Navigator.canPop(context) ? () => Navigator.pop(context) : null;

    return NavigationView(
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: const Text(Strings.navigation),
          leading:  IconButton(
                        icon: const Center(child: Icon(FluentIcons.back, size: 12.0)), 
                        onPressed: onPressed
                    )
        ),
        pane: NavigationPane(
          header: const ProfileInfo(),
          selected: index,
          displayMode: PaneDisplayMode.auto,
          onChanged: (i) => ref.read(drawerIndexProvider.notifier).update((state) => state = i),
          items: user.rol.compareTo(Roles.admin) == 0 ? DrawerList.itemsAdmin : DrawerList.itemsCommercial,
          footerItems: [
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