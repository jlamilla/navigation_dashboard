import 'package:flutter/material.dart';
import 'package:navigation_dashboard/ui/pages/auth/components/detail_side.dart';
import 'package:navigation_dashboard/ui/pages/auth/components/switcher_side.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double width = 200.0;
  double containerWidth = 0.0;
  double alignText = 0.0;
  double welcomeText = 0.0;
  double opacity = 1.0;
  late double oldRange;
  late double newRange;
  late double newValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
      reverseCurve: Curves.easeInOutSine,
    ));

    _controller.addListener(() {
      setState(() {
        if (_animation.value >= -1.0 && _animation.value <= 0.0) {
          oldRange = (0.0 - (-1.0));
          newRange = (300.0 - 200.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 200.0;
          width = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (150.0 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          containerWidth = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (-1.8 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          alignText = newValue;

          oldRange = (0.0 - (-1.0));
          newRange = (-7.0 - 0.0);
          newValue =
              (((_animation.value - (-1.0)) * newRange) / oldRange) + 0.0;
          welcomeText = newValue;
        } else {
          oldRange = (1.0 - (0.0));
          newRange = (200.0 - 300.0);
          newValue =
              (((_animation.value - (0.0)) * newRange) / oldRange) + 300.0;
          width = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 150.0);
          newValue =
              (((_animation.value - (0.0)) * newRange) / oldRange) + 150.0;
          containerWidth = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 1.8);
          newValue = (((_animation.value - (0.0)) * newRange) / oldRange) + 1.8;
          alignText = newValue;

          oldRange = (1.0 - (0.0));
          newRange = (0.0 - 7.0);
          newValue = (((_animation.value - (0.0)) * newRange) / oldRange) + 7.0;
          welcomeText = newValue;
        }
      });
    });
  }

  double align = -1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            DetailSide(animation: _animation),
            SwitcherSide(animation: _animation, containerWidth: containerWidth, welcomeText: welcomeText, controller: _controller, width: width, alignText: alignText),
          ],
        ),
      ),
    );
  }
}