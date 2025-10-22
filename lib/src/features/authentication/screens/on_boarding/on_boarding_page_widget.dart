import 'package:flutter/material.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({super.key, required this.model});

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(30),
      color: model.bgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Image(image: AssetImage(model.image), height: size.height * 0.4),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(model.subtitle, textAlign: TextAlign.center),
            ],
          ),
          Text(
            model.counterText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }
}
