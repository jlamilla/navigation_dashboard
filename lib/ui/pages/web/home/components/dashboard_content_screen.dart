import 'package:flutter/material.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_screen.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_analytic/analytic_cards.dart';

class DashboardContentScreen extends StatelessWidget {
  
  const DashboardContentScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 5,
          child: AnalyticCards()
        ),
        if(!AppScreen.isMobile)
        Expanded(
          flex: 2,
          child: Container()
        )
      ],
    );
  }
}