import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/pages/home/dashboard_screen.dart';
import '../../ui/constants/routes.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {

    Routes.dashboard: (BuildContext context) => const DashBoardScreen(),
  };
}
