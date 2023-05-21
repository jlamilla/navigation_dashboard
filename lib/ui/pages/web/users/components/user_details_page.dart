import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_user.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/info_no_select.dart';
import 'package:navigation_design/tokens/colors.dart';

class UserDetailPage extends ConsumerWidget {
  
  const UserDetailPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userSelectProvider);
    return  user == null
    ?  InfoNoSelect(
      title: Strings.users,
      content: 'Seleccionar la imagen del usuario que deseas ver a detalle desde :',
      icon: FluentIcons.contact,
      acton: () {
        final drawer = ref.watch(drawerIndexTypeProvider);
        ref.read(drawerIndexProvider.notifier).update((state) => state = drawer.users );
      }
    )
    : SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.vertical,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: ImageCustomUser(action: false,)
            ),
            Expanded(
              child: UserProfileDetails(user: user)
            ),
          ],
        ),
    );
  }
}

class UserProfileDetails extends StatelessWidget {
  
  const UserProfileDetails({Key? key, required this.user}) : super(key: key);
  final User user;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: TextBox(
                  textAlign: TextAlign.center,
                  placeholder: 'C.C.',
                  enabled: false,
                  style: TextStyle(
                    height: 1.8,
                    fontSize: 18
                  ), 
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: TextFormBox(
                  style: TextStyle(
                    height: 1.8,
                    fontSize: 18,
                    color: black.withOpacity(0.6),
                  ),
                  readOnly: true,
                  suffix: IconButton(
                        icon: const Icon(
                          FluentIcons.copy, 
                          size: 20, 
                          color: grey,
                        ), 
                          onPressed: (){
                              Clipboard.setData(ClipboardData(text: user.dni));
                          }
                  ),
                  initialValue: user.dni,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.name,
              value: user.name,
            ),
            TextUser(
              title: Fields.lastname,
              value: user.lastname,
            ),
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.numberPhone,
              value: user.phone,
              ),
            TextUser(
              title: Fields.landline,
              value: user.landline.isEmpty ? 'No tiene teléfono' : user.landline,
            ),
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.department,
              value: user.department
            ),
            TextUser(
              title: Fields.city,
              value: user.city
            ), 
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.address,
              value: user.address
            ),
            TextUser(
              title: Fields.email,
              value: user.email
            ),
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.role,
              value: user.rol
            ),
            TextUser(
              title: Fields.state,
              value: user.state
            ),
          ],
        ),
        Row(
          children: [
            TextUser(
              title: Fields.dateCreate,
              value: user.dateCreate
            ),
            TextUser(
              title: Fields.dateUpdate,
              value: user.dateUpdate
            ),
          ],
        ),
      ],
    );
  }
}

class TextUser extends StatelessWidget {
  const TextUser({
    super.key,
    required this.value,
    required this.title,
    this.flex
  });

  final String value;
  final String title;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InfoLabel(
          label: '$title :',
          child: TextFormBox(
            style: TextStyle(
              height: 1.8,
              fontSize: 18,
              color: black.withOpacity(0.6),
            ),
            readOnly: true,
            suffix: IconButton(
                  icon: const Icon(
                    FluentIcons.copy, 
                    size: 20, 
                    color: grey,
                  ), 
                    onPressed: (){
                        Clipboard.setData(ClipboardData(text: value));
                    }
            ),
            initialValue: value,
          ),
        ),
      ),
    );
  }
}