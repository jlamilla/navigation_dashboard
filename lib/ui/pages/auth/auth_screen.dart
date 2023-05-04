import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/widgets/auth_register/card_background.dart';
import 'package:navigation_dashboard/ui/widgets/auth_register/card_container.dart';
import 'package:navigation_design/atoms/nd_text.dart';
import 'package:navigation_design/tokens/colors.dart';
import 'components/auth_form_screen.dart';

class AuthScreen extends StatelessWidget {
  
  const AuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardBackground(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox( height: AppScreen.getHeightInPercent(30) ),
              Padding(
                padding: AppScreen.isDesktop ? EdgeInsets.symmetric(horizontal: AppScreen.getWidthInPercent(30)) : const EdgeInsets.all(0),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: CardContainer(
                    child: Column(
                      children: [
                        const H1(text: Strings.authTitle , color: black,),
                        SizedBox( height: AppScreen.getHeightInPercent(2) ),
                        const AuthFormScreen()
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}