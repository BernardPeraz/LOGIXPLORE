import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/colors.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 0,
            animate: TAnimatePosition(
              bottomAfter: 0,
              bottomBefore: -100,
              leftBefore: 0,
              leftAfter: 0,
              topAfter: 0,
              topBefore: 0,
              rightAfter: 0,
              rightBefore: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage(tWelcomeScreenImage),
                    height: height * 0.6,
                  ),
                  Column(
                    children: [
                      Text(
                        "Learn Logic Gates",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "Makes learning about logic gates fun",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.to(() => const LoginScreen()),
                          child: Text("LOGIN"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const SignupScreen()),

                          child: Text("SIGNUP"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
