import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/drawer_provider.dart';
import 'package:navigation_dashboard/config/providers/image_provider.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/user/user_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/image_custom/image_custom_user.dart';
import 'package:navigation_dashboard/ui/widgets/web/alerts/info_no_select.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_loading.dart';
import 'package:navigation_design/tokens/colors.dart';

class UserUpdatePage extends ConsumerWidget {
  
  const UserUpdatePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formProductAddKey = GlobalKey<FormState>();
    final user = ref.watch(userSelectProvider);
    return  user == null
    ?  InfoNoSelect(
      title: Strings.users,
      content: 'Seleccionar el usuario a modificar desde :',
      icon: FluentIcons.contact,
      acton: () {
        final drawer = ref.watch(drawerIndexTypeProvider);
        ref.read(drawerIndexProvider.notifier).update((state) => state = drawer.users );
      } 
    )
    : Form(
        key: formProductAddKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ImageCustomUser(state: user.state, action: true,)
              ),
              Expanded(
                child: UserProfileUpdate(formProductAddKey: formProductAddKey, user: user)
              ),
            ],
          ),
        ),
      );
  }
}

class UserProfileUpdate extends ConsumerStatefulWidget {

  const UserProfileUpdate({ super.key, required this.formProductAddKey, required this.user});
  final GlobalKey<FormState> formProductAddKey;
  final User user;

  @override
  UserProfileUpdateState createState() => UserProfileUpdateState();
}

class UserProfileUpdateState extends ConsumerState<UserProfileUpdate> {

  late TextEditingController _dniController;
  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  late TextEditingController _roleController;
  late TextEditingController _stateController;
  late TextEditingController _landlineController;
  late TextEditingController _phoneController;
  late TextEditingController _departmentController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;

  @override
  void initState() {
    _dniController = TextEditingController(text: widget.user.dni);
    _nameController = TextEditingController(text: widget.user.name);
    _lastnameController = TextEditingController(text: widget.user.lastname);
    _emailController = TextEditingController(text: widget.user.email);
    _roleController = TextEditingController(text: widget.user.rol);
    _stateController = TextEditingController(text: widget.user.state);
    _landlineController = TextEditingController(text: widget.user.landline);
    _phoneController = TextEditingController(text: widget.user.phone);
    _departmentController = TextEditingController(text: widget.user.department);
    _cityController = TextEditingController(text: widget.user.city);
    _addressController = TextEditingController(text: widget.user.address);
    super.initState();
  }
  @override
  void dispose() {
    _dniController.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _stateController.dispose();
    _landlineController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(authProvider.notifier).userProfile;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormBox(
                    textAlign: TextAlign.center,
                    placeholder: 'C.C.',
                    enabled: false,
                    style: const TextStyle(
                      height: 1.8,
                      fontSize: 18
                    ), 
                  ),
                ),
              ),
              TextUser(
                title: Fields.dni,
                flex: 3,
                controller: _dniController, 
                type: TextInputType.text,
                formatter: [Formatter.dni()],
                validator: (value) => Validations.validateDni(value),
              ),
            ],
          ),
          Row(
            children: [
              TextUser(
                title: Fields.name, 
                controller: _nameController, 
                type: TextInputType.text,
              ),
              TextUser(
                title: Fields.lastname, 
                controller: _lastnameController, 
                type: TextInputType.text,
              ),
            ],
          ),
          Row(
            children: [
              TextUser(
                title: Fields.numberPhone, 
                controller: _phoneController, 
                type: TextInputType.text,
                validator: (value) => Validations.validatePhoneNumber(value),
                formatter: [Formatter.phoneNumber()],
              ),
              TextUser(
                title: Fields.landline, 
                controller: _landlineController,
                type: TextInputType.text,
              ),
            ],
          ),
          Row(
            children: [
              AutoSuggestUserDepartment(
                controller: _departmentController, 
                title: Fields.department
              ),
              AutoSuggestUserCity(
                controller: _cityController, 
                title: Fields.city
              ),
              
            ],
          ),
          Row(
            children: [
              TextUser(
                title: Fields.address, 
                controller: _addressController, 
                type: TextInputType.text,
              ),
              TextUser(
                title: Fields.email, 
                controller: _emailController, 
                type: TextInputType.text,
                validator: (value)=> Validations.validateEmail(value),
              ),
            ],
          ),
          userProfile.id?.compareTo(widget.user.id ?? '') == 0 
          ? Row(
            children: [
              TextUserNotEdit(
                title: Fields.role,
                value: widget.user.rol,
              ),
              TextUserNotEdit(
                title: Fields.state,
                value: widget.user.state,
              ),
            ],
          )
          : Row(
            children: [
              userProfile.rol.compareTo(Roles.admin) == 0 
              ? ComboBoxUserRole(
                title: Fields.role, 
                controller: _roleController,
              )
              : TextUserNotEdit(
                title: Fields.role,
                value: widget.user.rol,
              ),
              ComboBoxUserState(
                title: Fields.state, 
                controller: _stateController,
              ),
            ],
          ),
          ButtonLoading(
            title: Strings.updateUser, 
            loading: 'Actualizando usuario...', 
            action: () async{
                if(widget.formProductAddKey.currentState!.validate()){
                  ref.read(loadingProvider.notifier).update((state) => !state);
                  widget.user.dni = _dniController.text;
                  widget.user.name = _nameController.text;
                  widget.user.lastname = _lastnameController.text;
                  widget.user.landline = _landlineController.text;
                  widget.user.phone = _phoneController.text;
                  widget.user.email = _emailController.text;
                  widget.user.department = _departmentController.text;
                  widget.user.city = _cityController.text;
                  widget.user.address = _addressController.text;
                  widget.user.rol = _roleController.text;
                  widget.user.state = _stateController.text;
                  widget.user.dateUpdate = Formatter.dateFormat();
                  if(await ref.read(userProvider.notifier).updateUser(widget.user, ref.read(photoProvider))){
                    if(context.mounted){
                      final drawer = ref.watch(drawerIndexTypeProvider);
                      ref.read(drawerIndexProvider.notifier).update((state) => state = drawer.users );
                      displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: const Text(Strings.successAlert),
                          content: Text('${Strings.successUserContent} ${widget.user.dni} ${Strings.successUpdateContent}'),
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                          severity: InfoBarSeverity.success,
                        );
                      });
                    }else{
                      ref.read(loadingProvider.notifier).update((state) => !state);
                      displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close){
                        return InfoBar(
                          title: const Text(Strings.errorAlert),
                          content: Text('${Strings.successUserContent} ${widget.user.dni} no ${Strings.successUpdateContent}'),
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                          severity: InfoBarSeverity.error,
                        );
                      });
                    }
                  }
                }else{
                  displayInfoBar(context, duration: const Duration(seconds: 5), builder: (context, close) {
                    return InfoBar(
                      title: const Text(Strings.errorAlert),
                      content: const Text(Strings.errorFormContent),
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
        ],
      ),
    );
  }
}

class ComboBoxUserState extends ConsumerWidget {
  const ComboBoxUserState({
    super.key, 
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ComboboxFormField<String>(
          placeholder: Text(title),
          value: controller.text,
          isExpanded: true,
          style: const TextStyle(
            textBaseline: TextBaseline.alphabetic,
            fontSize: 18
          ),
          items: CardColorUserState.values.map((user) {
                return ComboBoxItem(
                  value: user.state,
                  child: Text(user.state),
                );
              }).toList(),
          onChanged: (value) {
            if(value != null){
              controller.text = value;
              final userStateColor = CardColorUserState.values.where((element) => element.state.compareTo(value) == 0).toList();
              ref.read(userColorState.notifier).update((state) => state = userStateColor[0] );
            }
          },
          validator: (value) => Validations.validateSelect(value)
        ),
      ),
    );
  }
}

class ComboBoxUserRole extends ConsumerWidget {
  const ComboBoxUserRole({
    super.key, 
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ComboboxFormField<String>(
          placeholder: Text(title),
          value: controller.text,
          isExpanded: true,
          style: const TextStyle(
            textBaseline: TextBaseline.alphabetic,
            fontSize: 18
          ), 
          items: ListElement.rol.map((e) {
                return ComboBoxItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
          onChanged: (value) => controller.text = value ?? '',
          validator: (value) => Validations.validateSelect(value)
        ),
      ),
    );
  }
}

class AutoSuggestUserDepartment extends ConsumerWidget {
  const AutoSuggestUserDepartment({
    super.key, 
    required this.controller, 
    required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AutoSuggestBox<DepartmentCityType>.form(
          autovalidateMode : AutovalidateMode.onUserInteraction,
          maxPopupHeight: 200,
          style: const TextStyle(
            height: 1.8,
            fontSize: 18
          ),
          validator: (value) => Validations.validateSelectDepartment(value),
          controller: controller,
          placeholder: title,
          items: ListElement.departmentMunicipal.map((site) {
            return AutoSuggestBoxItem<DepartmentCityType>(
              value: site,
              label:  site.department,
            );
          }).toList(),
          onSelected: (item) {
            controller.text = item.value?.department ?? '';
            if(item.value != null){
              ref.read(userDepartmentMunicipal.notifier).update((state) => state = item.value);
            }
          },
        ),
      ),
    );
  }
}

class AutoSuggestUserCity extends ConsumerWidget {
  const AutoSuggestUserCity({
    super.key, 
    required this.controller, 
    required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(userDepartmentMunicipal)?.municipal ?? [];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AutoSuggestBox<String>.form(
          autovalidateMode : AutovalidateMode.onUserInteraction,
          maxPopupHeight: 300,
          style: const TextStyle(
            height: 1.8,
            fontSize: 18
          ),
          validator: (value) => Validations.validateSelectMunicipal(value, list ),
          controller: controller,
          placeholder: title,
          items: list.map((municipal) {
            return AutoSuggestBoxItem<String>(
              value: municipal,
              label:  municipal,
            );
          }).toList(),
          onSelected: (municipal) {
            controller.text = municipal.value ?? '';
          },
        ),
      ),
    );
  }
}

class TextUser extends StatelessWidget {
  const TextUser({
    super.key,
    required this.controller, 
    this.formatter, 
    required this.title, 
    this.type, 
    this.validator,
    this.flex
  });

  final TextEditingController controller;
  final String title;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormBox(
          style: const TextStyle(
            height: 1.8,
            fontSize: 18
          ), 
          placeholder: title,
          keyboardType: type, 
          controller: controller ,
          validator: validator,
          inputFormatters: formatter,
        ),
      ),
    );
  }
}

class TextUserNotEdit extends StatelessWidget {
  const TextUserNotEdit({
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
    );
  }
}