import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/ui/constants/roles.dart';
import 'package:navigation_dashboard/ui/pages/home/components/dashboard_content_screen.dart';
import 'package:navigation_dashboard/ui/widgets/web/drawer/drawer_list.dart';

final drawerProvider = StateProvider<Widget>((ref) => const DashboardContentScreen());

final drawerIndexProvider = StateProvider<int?>((ref) => 0);

final drawerIndexTypeProvider = StateProvider<DrawerIndex>((ref) {
  final user = ref.watch(authProvider.notifier).userProfile;
  return user.rol.compareTo(Roles.admin) == 0 ? DrawerIndex.adminIndex : DrawerIndex.commercialIndex;
});

