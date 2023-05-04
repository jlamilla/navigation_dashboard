import 'package:flutter/material.dart';
import '../../ui/constants/routes.dart';

class AppNavigator {
  static AppNavigator of(BuildContext context) => AppNavigator(context);

  AppNavigator(BuildContext context) {
    _navigator = Navigator.of(context);
  }

  late final NavigatorState _navigator;

  toAdminHomeScreen() {
    _navigator.pushNamed(Routes.dashboard);
  }

  toAnimationScreenReplacement(BuildContext context, Route transition){
    return Navigator.pushReplacement(context, transition);
  }

  toAnimationScreen(BuildContext context, Route transition){
    return Navigator.push(context, transition);
  }

  toScreen(BuildContext context, Widget screen) {
    return _navigator.push(MaterialPageRoute(builder: (context) => screen),);
  }
  toScreenReplacement(BuildContext context, Widget screen) {
    return _navigator.pushReplacement(MaterialPageRoute(builder: (context) => screen),);
  }
}
