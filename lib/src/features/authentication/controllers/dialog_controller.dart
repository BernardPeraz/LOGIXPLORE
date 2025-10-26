// responsive_helper.dart
import 'package:flutter/material.dart';

class DialogController {
  static double getDialogWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return screenWidth * 0.95;
    } else if (screenWidth < 900) {
      return screenWidth * 0.85;
    } else {
      return 900;
    }
  }

  static double getDialogHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return screenHeight * 0.85;
    } else {
      return 600;
    }
  }

  static double getImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return 200;
    } else {
      return 200;
    }
  }

  static double getImageWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return screenWidth * 0.6;
    } else {
      return 300;
    }
  }

  static double getButtonWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return screenWidth * 0.6;
    } else {
      return 300;
    }
  }

  static double getFontSize(BuildContext context, bool isTitle) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return isTitle ? 20 : 14;
    } else {
      return isTitle ? 28 : 16;
    }
  }

  static EdgeInsets getPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return EdgeInsets.all(15);
    } else {
      return EdgeInsets.all(25);
    }
  }
}
