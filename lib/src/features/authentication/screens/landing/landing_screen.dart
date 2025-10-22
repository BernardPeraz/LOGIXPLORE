import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/colors.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Text(
          "LOGIXPLORE",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: tCardBgColor,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Image(image: AssetImage(tUserProfileImage)),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundImageLight),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: []),
      ),
    );
  }
}
