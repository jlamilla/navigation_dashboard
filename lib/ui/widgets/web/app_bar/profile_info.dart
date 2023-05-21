import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProfileInfo extends ConsumerWidget {
  
  const ProfileInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(authProvider.notifier).userProfile;
    return IconButton(
      onPressed: (){
        ref.watch(photoURLProvider.notifier).update((state) => state = userProfile.photoURL);
        ref.watch(userSelectProvider.notifier).update((state) => state = userProfile);
        final userStateColor = CardColorUserState.values.where((element) => element.state.compareTo(userProfile.state) == 0).toList();
        ref.watch(userColorState.notifier).update((state) => state = userStateColor[0] );
        final userDepartment = DepartmentCityType.values.where((element) => element.department.compareTo(userProfile.department) == 0).toList();
        ref.watch(userDepartmentMunicipal.notifier).update((state) => state = userDepartment[0] );
        final drawer = ref.watch(drawerIndexTypeProvider);
        ref.watch(drawerIndexProvider.notifier).update((state) => state= drawer.userUpdate);
      },
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: userProfile.photoURL.isEmpty 
                      ? const OurAssetImage(assetName: Images.noPhoto, heightImage: 70, placeholder: Images.loading)
                      : OurNetworkImage(url: userProfile.photoURL, heightImage: 70, placeholder: Images.loading)
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userProfile.name} ${userProfile.lastname}',
                  style: FluentTheme.of(context).typography.body?.apply(color: black)
                ),
                Text(
                  userProfile.rol, 
                  style: FluentTheme.of(context).typography.caption?.apply(color: black)
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}