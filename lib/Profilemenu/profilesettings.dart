import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettingwidget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
          title: Text(
            "PROFILE SETTINGS",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          elevation: 1,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
          actions: [
            Padding(padding: const EdgeInsets.only(right: 16.0)),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? BackgroundImageLight
                  : BackgroundImageDark,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            ProfileWidget(),
          ],
        ),
      ),
    );
  }
}
