import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/card_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/search_providers.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/responsive.dart';
import 'package:navigation_dashboard/ui/widgets/skelton_loading/user_grid_view_skelton.dart';
import 'package:navigation_dashboard/ui/widgets/web/app_bar/custom_appbar.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_buttons.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_category/card_category.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_image/card_image.dart';
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
    return usersData.when(
      data: (users){
        return  Consumer(
          builder: (_, WidgetRef ref, __) { 
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
        );
      },
      error: (error, stackTrace) => const H2(text: 'No hay usuarios registrados'),
      loading: () => UserGridViewSkelton(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, itemCount: 4)
    );
  }
}

class UserCard extends StatelessWidget {
  
  const UserCard({Key? key, required this.userInfo, required this.cardInfo}) : super(key: key);

  final User userInfo;
  final AnalyticData cardInfo;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow( color: boxShadow1, blurRadius: 10, offset: const Offset(0, 5) )],
      ),
      child: Column(
        children: [
          CardImage(userImage: userInfo.photoURL, cardInfo: cardInfo),
          UserCardContentInfo(userInfo: userInfo),
          CardButtons( 
            userId: userInfo.id!,
            onPressedButtonEdit: (){

            },
            onPressedButtonDelete: () {
              
            },
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 1,
              color: primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email, color: grey, size: 20),
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
                const Icon(Icons.phone_android, color: grey, size: 20,),
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
                const Icon(Icons.home, color: grey, size: 20,),
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