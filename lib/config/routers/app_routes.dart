import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/constants/routes.dart';
import 'package:navigation_dashboard/ui/pages/web/home/dashboard_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.dashboard: (BuildContext context) => const DashBoardScreen(),
  };
}
