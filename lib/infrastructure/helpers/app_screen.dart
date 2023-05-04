import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppScreen {
  static AppScreen initialize(BuildContext context) => AppScreen(context);

  AppScreen(BuildContext context) {
    _size = MediaQuery.of(context).size;
  }

  static late Size _size;

  static double get getWidthSize {
    return _size.width;
  }

  static double get getHeightSize {
    return _size.height;
  }

  static double get getDiagonalSize {
    return math.sqrt(math.pow(getWidthSize, 2) + math.pow(getHeightSize, 2));
  }

  static bool get isMobile {
    return _size.width < 850;
  }

  static bool get isTablet {
    return _size.width < 1100 && _size.width >= 850;
  }

  static bool get isDesktop {
    return _size.width >= 1100;
  }

  static double getWidthInPercent(double value) {
    return (value * getWidthSize) / 100;
  }

  static double getHeightInPercent(double value) {
    return (value * getHeightSize) / 100;
  }

  static double getDiagonalInPercent(double value) {
    return (value * getDiagonalSize) / 100;
  }
}
