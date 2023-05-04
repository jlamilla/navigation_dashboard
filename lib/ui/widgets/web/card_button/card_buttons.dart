
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_button/card_elevation_button.dart';

class CardButtons extends StatelessWidget {
  const CardButtons({ super.key, this.onPressedButtonEdit, this.onPressedButtonDelete, this.userId='',});
  final Function()? onPressedButtonEdit;
  final Function()? onPressedButtonDelete;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final user = ref.watch(authProvider.notifier).userProfile;
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: CardElevationButton(
                      title: Strings.buttonEdit, 
                      onPressed: onPressedButtonEdit,
                      type: (user.rol == Roles.commercial || user.id == userId)
                            ? ButtonRadius.center 
                            : ButtonRadius.left,
                    ),
            ),
            if(user.rol == Roles.admin && user.id != userId)
            Expanded(
              flex: 1,
              child: CardElevationButton(
                      title: Strings.buttonDelete, 
                      onPressed: onPressedButtonDelete,
                      type: ButtonRadius.right
                    ),
            ),
          ],
        );
      },
    );
  }
}