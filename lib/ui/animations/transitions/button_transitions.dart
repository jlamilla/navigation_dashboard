import 'package:flutter/material.dart';

class ButtonPageTransitions{
  Route animateRoute(Widget widget){
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end:  1.0).animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}