// Responsive Class
import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double getPadding(BuildContext context) {
    if (isDesktop(context)) return 40.0;
    if (isTablet(context)) return 30.0;
    return 20.0;
  }

  static double getIconSize(BuildContext context) {
    if (isDesktop(context)) return 28.0;
    if (isTablet(context)) return 24.0;
    return 20.0;
  }

  static double getFontSize(BuildContext context) {
    if (isDesktop(context)) return 18.0;
    if (isTablet(context)) return 9.0;
    return 9.0;
  }

  static double getButtonHeight(BuildContext context) {
    if (isDesktop(context)) return 70.0;
    if (isTablet(context)) return 60.0;
    return 50.0;
  }
}
