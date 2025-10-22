import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/editprofile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/logo/logicon.png'),
          title: Text(
            "PROFILE SETTINGS",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),

        body: Stack(
          children: [
            Image.asset(
              BackgroundImageLight,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Editprofile(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
