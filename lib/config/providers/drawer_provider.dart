import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/ui/pages/web/home/components/dashboard_content_screen.dart';

final drawerProvider = StateProvider<Widget>((ref) => const DashboardContentScreen());

final drawerIndexProvider = StateProvider<int>((ref) => 0);
