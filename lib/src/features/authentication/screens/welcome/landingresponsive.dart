// DAGDAG: Ito ang bagong widget para sa responsiveness

import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/responsiveness/landingdesk.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/responsiveness/landingmobile.dart';

class LandingResponsive extends StatelessWidget {
  const LandingResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Gamitin ang constraints instead of MediaQuery
        if (constraints.maxWidth > 750) {
          return const Landingdesktop();
        } else {
          return const Landingmobile();
        }
      },
    );
  }
}
