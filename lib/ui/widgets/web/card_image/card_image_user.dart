
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/ui/constants/images.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image_background.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';
import 'package:navigation_design/atoms/nd_image.dart';
import 'package:navigation_design/tokens/colors.dart';

class CardImageUser extends ConsumerWidget {
  const CardImageUser({ super.key, required this.cardInfo, required this.user, required this.drawer});
  final AnalyticData cardInfo;
  final User user;
  final DrawerIndex drawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () async{
          ref.watch(photoURLProvider.notifier).update((state) => state = user.photoURL);
          ref.watch(userSelectProvider.notifier).update((state) => state = user);
          final orderStateColor = CardColorUserState.values.where((element) => element.state.compareTo(user.state) == 0).toList();
          ref.watch(userColorState.notifier).update((state) => state = orderStateColor[0] );
          ref.watch(drawerIndexProvider.notifier).update((state) => state = drawer.userDetails);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CardImageBackground(color: cardInfo.color,),
            Container(
              padding: const EdgeInsets.only( bottom: 4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: white
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: (user.photoURL.isNotEmpty) 
                      ? OurNetworkImage(
                          url: user.photoURL, 
                          placeholder: Images.loading, 
                          widthImage: 130, 
                          heightImage: 130,
                        )
                      : OurAssetImage( 
                          assetName: cardInfo.imageCard!,  
                          placeholder: Images.loading, 
                          widthImage: 130, 
                          heightImage: 130,
                        )   
              ),
            ),
          ]
        ),
      ),
    );
  }
}
