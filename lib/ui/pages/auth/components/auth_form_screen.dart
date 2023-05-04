import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/routers/app_navigator.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/auth_state_changes_custom.dart';
import 'package:navigation_dashboard/ui/animations/transitions/page_transitions.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/pages/auth/auth_restore_password_screen.dart';
import 'package:navigation_design/atoms/nd_button.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/atoms/nd_text_form.dart';

class AuthFormScreen extends StatelessWidget {
  const AuthFormScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    AppNavigator navigation = AppNavigator(context);
    final formAuthKey = GlobalKey<FormState>();
    return Form(
      key: formAuthKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final authForm = ref.watch(authProvider.notifier);
        final obscureText = ref.watch(obscureTextProvider);
        return Column(
            children: [
              TextFormAuth(
                label: Strings.authUserEmail,
                keyBoardType: TextInputType.emailAddress, 
                validator: (value) => Validations.validateEmail(value),
                onChanged: ( value ) => authForm.email = value,
                prefixIcon: Icons.email_outlined,
              ),
              TextFormAuth(
                label: Strings.authUserPassword, 
                keyBoardType: TextInputType.text, 
                validator: (value) => Validations.validatePassword(value),
                onChanged: ( value ) => authForm.password = value,
                prefixIcon: Icons.lock_outline,
                obscureText: obscureText,
                onPressedObscureTextFalse: () => ref.read(obscureTextProvider.notifier).update((state) => !state) ,
                onPressedObscureTextTrue: () => ref.read(obscureTextProvider.notifier).update((state) => !state) ,
              ),
              // The user is directed to the password reset screen
              Padding(
                padding: EdgeInsets.only(left: AppScreen.getWidthInPercent(24)),
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(context, PageTransitions().animateRoute(const AuthRestorePasswordScreen())),
                  child: const LinkText(text: Strings.userPasswordReset,)
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppScreen.getWidthInPercent(5)),
                child: ButtonNormal(
                  title: Strings.auth, 
                  onTap:() async {
                    FocusScope.of(context).unfocus();
                    //Validate the form data
                    if(!formAuthKey.currentState!.validate()) return;
                    //validate if the email and password are correct and if the user exists
                    final bool  validate = await authForm.signInEmailandPassword(context);
                    if( validate && context.mounted){
                      navigation.toScreenReplacement(context, const AuthStateChangesCustom());
                    }
                  }
                ),
              ),
            ]
          );
          }
      ),
    );
  }
}