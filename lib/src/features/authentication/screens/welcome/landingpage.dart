import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingresponsive.dart';

class Landingpagee extends StatelessWidget {
  const Landingpagee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingResponsive(), // PALIT: Gumawa ng bagong widget
    );
  }
}
