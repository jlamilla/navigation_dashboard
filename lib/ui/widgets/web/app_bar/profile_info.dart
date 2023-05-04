import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';

class ProfileInfo extends ConsumerWidget {
  
  const ProfileInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(authProvider.notifier).userProfile;
    return GestureDetector(
      onTap: (){ print('Perfil');},
      child: Container(
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