import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/pages/web/home/dashboard_screen.dart';
import '../../ui/constants/routes.dart';
import '../../ui/pages/auth/auth_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {

    Routes.auth: (BuildContext context) => const AuthScreen(),
    Routes.dashboard: (BuildContext context) => const DashBoardScreen(),
  };
}
