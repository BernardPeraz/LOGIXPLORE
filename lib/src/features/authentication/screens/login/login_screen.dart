import 'package:flutter/material.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen_mobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen_website.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileLoginScreen();
        } else {
          return WebsiteLoginScreen();
        }
      },
    );
  }
}
