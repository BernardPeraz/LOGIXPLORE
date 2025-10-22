import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: (MediaQuery.of(context).size.height / 2) - 250,
              topBefore: 0,
              leftAfter: (MediaQuery.of(context).size.width / 2) - 164,
              leftBefore: (MediaQuery.of(context).size.width / 2) - 164,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "LOGIXPLORE",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  "learn about logic gates",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: (MediaQuery.of(context).size.height / 2) - 146,
              topBefore: 0,
              leftAfter: (MediaQuery.of(context).size.width / 2) - 128,
              leftBefore: (MediaQuery.of(context).size.height / 2) - 146,
            ),
            child: Image(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.light
                    ? tSplashImageDark1
                    : tSplashImageLight1,
              ),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: (MediaQuery.of(context).size.height / 2) - 146,
              topBefore: 0,
              rightAfter: (MediaQuery.of(context).size.width / 2) - 127,
              rightBefore: (MediaQuery.of(context).size.height / 2) - 146,
            ),
            child: Image(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.light
                    ? tSplashImageDark2
                    : tSplashImageLight2,
              ),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              bottomAfter: (MediaQuery.of(context).size.height / 2) - 159,
              bottomBefore: 0,
              leftAfter: (MediaQuery.of(context).size.width / 2) - 128,
              leftBefore: (MediaQuery.of(context).size.height / 2) - 146,
            ),
            child: Image(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.light
                    ? tSplashImageDark3
                    : tSplashImageLight3,
              ),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              bottomAfter: (MediaQuery.of(context).size.height / 2) - 159,
              bottomBefore: 0,
              rightAfter: (MediaQuery.of(context).size.width / 2) - 127,
              rightBefore: (MediaQuery.of(context).size.height / 2) - 146,
            ),
            child: Image(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.light
                    ? tSplashImageDark4
                    : tSplashImageLight4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
