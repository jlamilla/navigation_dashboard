import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/routers/app_navigator.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/animations/transitions/page_transitions.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/pages/auth/auth_screen.dart';
import 'package:navigation_design/atoms/nd_button.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/atoms/nd_text_form.dart';
import 'package:navigation_design/tokens/colors.dart';

class AuthFormRestorePasswordScreen extends StatelessWidget {
  const AuthFormRestorePasswordScreen ({super.key});
  
  @override
  Widget build(BuildContext context) {

    AppNavigator navigation = AppNavigator(context);
    final formRestoreKey = GlobalKey<FormState>();

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formRestoreKey,
      child: Column(
        children: [
          const H1(text: Strings.userPasswordResetContent, color: black,),
          SizedBox( height: AppScreen.getHeightInPercent(1) ),
          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              children: [
                TextFormAuth(label: Strings.authUserEmail, 
                  keyBoardType: TextInputType.emailAddress, 
                  validator: (value) => Validations.validateEmail(value),
                  onChanged: ( value ) => ref.read(authProvider.notifier).email = value,
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox( height: AppScreen.getHeightInPercent(2.5) ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppScreen.getWidthInPercent(5)),
                  child: ButtonNormal(title: Strings.emailSendResetPassword, onTap: () async {
                      FocusScope.of(context).unfocus();
                      if(!formRestoreKey.currentState!.validate()) return;
                      if(await ref.read(authProvider.notifier).restorePassword()){
                        //alert.scaffoldMessenger(Strings.successAlert,Strings.resetPasswordAlert, ContentType.success);
                        if(context.mounted){
                          navigation.toAnimationScreenReplacement(context, PageTransitions().animateRoute(const AuthScreen()));
                        }
                      }else{
                        //alert.scaffoldMessenger(Strings.error, Strings.resetPasswordAlertError, ContentType.failure);
                      }
                    }),
                ),
              ],
            );
          },),
          SizedBox( height: AppScreen.getHeightInPercent(1) ),
          TextButton(
            onPressed: () => navigation.toAnimationScreenReplacement(context, PageTransitions().animateRoute(const AuthScreen())),
            child: const LinkText(text: Strings.authContent))
        ],
      ),
    );
  }
}