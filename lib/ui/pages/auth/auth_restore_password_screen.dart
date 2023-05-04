import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/pages/auth/components/auth_form_restore_password_screen.dart';
import 'package:navigation_dashboard/ui/widgets/auth_register/card_background.dart';
import 'package:navigation_dashboard/ui/widgets/auth_register/card_container.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';


class AuthRestorePasswordScreen extends StatelessWidget {
  const AuthRestorePasswordScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardBackground(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox( height: AppScreen.getHeightInPercent(30) ),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: CardContainer(
                  child: Column(
                    children: [
                      SizedBox( height: AppScreen.getHeightInPercent(0.2) ),
                      const H1(text: Strings.userPasswordResetTitle, color: black,),
                      const AuthFormRestorePasswordScreen()
                    ],
                  )
                ),
              ),
              //const AuthNewsScreen(),
            ],
          ),
        )
      )
    );
  }
}