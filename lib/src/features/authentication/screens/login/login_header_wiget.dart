import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: size.height * 0.2,
        ),
        Text(
          "Welcome Back,",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Learn Logic Gates much faster, easier, more convinient",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
