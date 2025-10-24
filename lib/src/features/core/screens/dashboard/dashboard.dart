import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profile.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/colors.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard_block.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double blockWidth = screenWidth > 900
        ? (screenWidth / 3) - 60
        : screenWidth > 600
        ? (screenWidth / 2) - 30
        : screenWidth - 20;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
        title: Text(
          "LOGIXPLORE",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 1,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(0, 247, 246, 241),
            ),
            child: IconButton(
              onPressed: () {
                ThemeData theme = Theme.of(context);
                bool isDark = theme.brightness == Brightness.dark;
                Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: tDarkColor,
              ),
            ),
          ),

          ProfileMenuBox(),

          IconButton(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              double screenWidth = MediaQuery.of(context).size.width;

              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 80, 20, 0),
                items: [
                  if (screenWidth < 600 && user != null)
                    PopupMenuItem(
                      enabled: false,
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user.displayName?.isNotEmpty == true
                                  ? user.displayName!
                                  : user.email ?? 'No Email Found',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                  PopupMenuItem(
                    child: const Text("Profile"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileSettings(),
                        ),
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Logout"),
                    onTap: () async {
                      Future<void> signOutUser() async {
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                      }

                      await signOutUser();
                    },
                  ),
                ],
              );
            },
          ),

          const SizedBox(width: 15),
        ],
      ),

      body: Stack(
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? BackgroundImageLight
                : BackgroundImageDark,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 35,
                  runSpacing: 30,
                  children: [
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[300],
                      text: "And",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[400],
                      text: "Block 2",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[500],
                      text: "Block 3",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[600],
                      text: "Block 4",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[700],
                      text: "Block 5",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[800],
                      text: "Block 6",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[800],
                      text: "Block 7",
                      image: "assets/logo/annd.jpg",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
