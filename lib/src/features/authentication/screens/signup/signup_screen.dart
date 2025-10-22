import 'package:flutter/material.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen_mobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen_website.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileSignupScreen();
        } else {
          return WebsiteSignupScreen();
        }
      },
    );
  }
}
