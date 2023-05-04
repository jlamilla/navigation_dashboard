import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/analytic_data_provider.dart';
import 'package:navigation_dashboard/config/providers/user_provider.dart';
import 'package:navigation_dashboard/domain/models/analytic/analytic_data_model.dart';
import 'package:navigation_dashboard/infrastructure/helpers/fields.dart';
import 'package:navigation_dashboard/infrastructure/helpers/formatter.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/image_custom/image_custom.dart';
import 'package:navigation_design/tokens/colors.dart';



class UserCreatePage extends StatelessWidget {
  
  const UserCreatePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final formProductAddKey = GlobalKey<FormState>();

    return Form(
        key: formProductAddKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: ImageCustomCardState()
              ),
              Expanded(
                child: UserProfileCreate(formProductAddKey: formProductAddKey)
              ),
            ],
          ),
        ),
      );
  }
}

class UserProfileCreate extends ConsumerStatefulWidget {

  const UserProfileCreate({ super.key, required this.formProductAddKey,});
  final GlobalKey<FormState> formProductAddKey;

  @override
  UserProfileCreateState createState() => UserProfileCreateState();
}

class UserProfileCreateState extends ConsumerState<UserProfileCreate> {

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
    _dniController = TextEditingController();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _roleController = TextEditingController();
    _stateController = TextEditingController();
    _landlineController = TextEditingController();
    _phoneController = TextEditingController();
    _departmentController = TextEditingController();
    _cityController = TextEditingController();
    _addressController = TextEditingController();
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
                validator: (value) => Validations.validateNoEmpty(value),
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
          Row(
            children: [
              ComboBoxUserRole(
                title: Fields.role, 
                controller: _roleController,
              ),
              ComboBoxUserState(
                title: Fields.state, 
                controller: _stateController,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: ButtonState.all(primaryColor),
                      padding: ButtonState.all(const EdgeInsets.all(20)),
                      textStyle: ButtonState.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text(Strings.createUser),
                    onPressed: (){
                      if(widget.formProductAddKey.currentState!.validate()){
                        displayInfoBar(context, builder: (context, close) {
                          return InfoBar(
                            title: const Text(Strings.successAlert),
                            content: const Text('UI INTERFACE SUCCESS'),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.success,
                          );
                        });
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
                ),
              ),
            ],
          )
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
    final userState = ref.watch(userColorState);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ComboboxFormField<CardColorUserState>(
          placeholder: Text(title),
          value: userState,
          isExpanded: true,
          style: const TextStyle(
            textBaseline: TextBaseline.alphabetic,
            fontSize: 18
          ),
          items: CardColorUserState.values.map((user) {
                return ComboBoxItem(
                  value: user,
                  child: Text(user.state),
                );
              }).toList(),
          onChanged: (value) {
            if(value != null){
              controller.text = value.state;
              ref.read(userColorState.notifier).update((state) => state = value );
            }
          },
          validator: (value) => Validations.validateSelect(value?.state)
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
            ref.read(userDepartmentMunicipal.notifier).update((state) => state = item.value ?? DepartmentCityType.select);
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
    final list = ref.watch(userDepartmentMunicipal).municipal;
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
          enabled: list.isNotEmpty,
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
