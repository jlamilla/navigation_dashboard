import 'package:flutter/material.dart';

class PageTransitions{
  Route animateRoute(Widget widget){
  return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
        return SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}