import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/pages/auth/auth_page.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_menu.dart';
import 'package:navigation_design/pages/sizes_pages.dart';
import 'app_screen.dart';


class AuthStateChangesCustom extends ConsumerWidget {

  const AuthStateChangesCustom({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return StreamBuilder(
        stream: ref.watch(authProvider.notifier).userSessionChanges(),
        builder: (context, snapshot) {
          AppScreen.initialize(context);
          SizesPages.initialize(context);
          if(snapshot.hasData){
            return const _StreamUserProfile();
          }else{
            return const AuthPage();
          }
        }
    );
  }
}

class _StreamUserProfile extends ConsumerWidget {
  
  const _StreamUserProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStatusStreamProvider);

    return userState.when(
      data: (User user) {
        if(user.state == Strings.userActive){
            ref.read(authProvider.notifier).user = user;
            return const DrawerMenu();
        }else{
            ref.watch(authProvider.notifier).signOut();
            return Container();
        }
      }, 
      error: (Object error, StackTrace stackTrace) => const Text('Error'), 
      loading: () => const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: ProgressRing()
                      )
                    ),
    );
  }
}