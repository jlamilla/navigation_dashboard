import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/card_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/alerts.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image_user.dart';
import 'package:navigation_dashboard/ui/widgets/web/grid_view/grid_view_data.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';

class UsersPage extends StatelessWidget {
  
  const UsersPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Responsive(
            mobile: UserStream(
              crossAxisCount: AppScreen.getWidthSize < 650 ? 1 : 2,
              childAspectRatio: AppScreen.getWidthSize < 650 ? 1 : 1,
            ),
            tablet: const UserStream(),
            desktop: UserStream(
              crossAxisCount: AppScreen.getWidthSize < 1400 ? 3 : 4,
            ),
        );
  }
}

class UserStream extends ConsumerWidget {
  const UserStream({super.key, this.crossAxisCount = 3, this.childAspectRatio = 0.7,});

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersData = ref.watch(usersFutureProvider);
    final userRole = ref.watch(authProvider.notifier).userProfile.rol;
    return usersData.when(
      data: (users){
        users = userRole.compareTo(Roles.commercial)== 0 
        ? users.where((u) => 0 == u.rol.compareTo(Roles.seller)).toList()
        : users;
        final usersFilter = ref.watch(searchNotifierProvider(users).notifier).filterUser();
        ref.watch(cardUserProvider.notifier).cardUser(usersFilter);
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: CardCategory(data: users)
            ),
            Expanded(
              flex: 5,
              child: GridViewData(
                crossAxisCount: crossAxisCount, 
                childAspectRatio: childAspectRatio,
                users: usersFilter,
                itemCount: usersFilter.length,
              )
            ),
          ],
        );
      },
      error: (error, stackTrace) => const H2(text: 'No hay usuarios registrados'),
      loading: () => UserGridViewSkelton(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, itemCount: 4)
    );
  }
}

class UserCard extends ConsumerWidget {
  
  const UserCard({Key? key, required this.userInfo, required this.cardInfo}) : super(key: key);

  final User userInfo;
  final AnalyticData cardInfo;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawer = ref.watch(drawerIndexTypeProvider);
    final userProfile = ref.watch(authProvider.notifier).userProfile;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow( color: boxShadow1, blurRadius: 10, offset: const Offset(0, 5) )],
      ),
      child: Column(
        children: [
          CardImageUser(cardInfo: cardInfo, user: userInfo, drawer: drawer),
          UserCardContentInfo(userInfo: userInfo),
          Visibility(
            visible: userInfo.rol.compareTo(Roles.seller) == 0 || userInfo.id?.compareTo(userProfile.id ?? '') == 0,
            child: CardButtons( 
              userId: userInfo.id!,
              onPressedButtonEdit: (){
                ref.watch(photoURLProvider.notifier).update((state) => state = userInfo.photoURL);
                ref.watch(userSelectProvider.notifier).update((state) => state = userInfo);
                final userStateColor = CardColorUserState.values.where((element) => element.state.compareTo(userInfo.state) == 0).toList();
                ref.watch(userColorState.notifier).update((state) => state = userStateColor[0] );
                final userDepartment = DepartmentCityType.values.where((element) => element.department.compareTo(userInfo.department) == 0).toList();
                ref.watch(userDepartmentMunicipal.notifier).update((state) => state = userDepartment[0] );
                ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.userUpdate);
              },
              onPressedButtonDelete: () async{
                final validate = await AlertCustom().showContentDialog(
                  title: Strings.deleteTitleUser, 
                  content: Strings.deleteContentUser,
                  context: context, 
                  action: () async{
                    return Navigator.pop(context, await ref.read(userProvider.notifier).deleteUser(userInfo));
                  }, 
                );
                if(validate && context.mounted){
                  ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.dashboard);
                  displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                    return InfoBar(
                      title: const Text(Strings.successAlert),
                      content: Text('${Strings.successUserContent} ${userInfo.dni} ${Strings.successDeleteContent}'),
                      action: IconButton(
                        icon: const Icon(FluentIcons.clear),
                        onPressed: close,
                      ),
                      severity: InfoBarSeverity.success,
                    );
                  });    
                }else{
                  displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                    return InfoBar(
                      title: const Text(Strings.errorAlert),
                      content: Text('${Strings.successUserContent} ${userInfo.dni} no ${Strings.successDeleteContent}'),
                      action: IconButton(
                        icon: const Icon(FluentIcons.clear),
                        onPressed: close,
                      ),
                      severity: InfoBarSeverity.error,
                    );
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class UserCardContentInfo extends StatelessWidget {
  const UserCardContentInfo({ super.key, required this.userInfo,});

  final User userInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          Text('C.C. ${userInfo.dni}', style: const TextStyle( fontSize: 18, fontWeight: FontWeight.w600)),
          Text('${userInfo.name} ${userInfo.lastname}', style: const TextStyle( fontSize: 15, fontWeight: FontWeight.w400)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Divider(
              style: DividerThemeData(
                thickness: 1,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.mail, color: grey, size: 20),
                const SizedBox(width: 5,),
                Text(userInfo.email),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.cell_phone, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text('+57 ${userInfo.phone}'),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FluentIcons.home, color: grey, size: 20,),
                const SizedBox(width: 5,),
                Text(userInfo.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}