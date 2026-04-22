import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/adminlogin/adminlogin.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/splash_screen/splash_screens.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/adminoverallui.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/resultscores.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/simulatorprogress.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/studentprogress.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  bool isSidebarVisible = true;

  Future<void> _signOutUser() async {
    FirebaseAuth.instance.currentUser?.email;
    await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.currentUser;
    Get.offAll(Adminlogin());
  }

  int selectedIndex = 0;

  final List<Widget> pages = [
    Adminoverallui(),
    Dashboard(),
    StudentProgressPage(),
    ResultScores(),
    Simulatorprogress(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // LEFT FIXED SIDEBAR
              isSidebarVisible
                  ? Container(
                      width: 170,

                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 110),

                                ListTile(
                                  selected: selectedIndex == 0,
                                  selectedTileColor: Colors.blue,

                                  leading: Icon(
                                    Icons.dashboard_rounded,
                                    color: Colors.deepPurple,
                                  ),
                                  title: Text(
                                    "Admin Dashboard",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() => selectedIndex = 0);
                                  },
                                ),

                                ListTile(
                                  selected: selectedIndex == 1,
                                  selectedTileColor: Colors.blue,
                                  leading: Icon(
                                    Icons.library_books_rounded,
                                    color: Colors.cyanAccent,
                                  ),
                                  title: Text(
                                    "Modules",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() => selectedIndex = 1);
                                  },
                                ),

                                ListTile(
                                  selected: selectedIndex == 2,
                                  selectedTileColor: Colors.blue,
                                  leading: Icon(
                                    Icons.bar_chart,
                                    color: Colors.orange,
                                  ),
                                  title: Text(
                                    "Student Progress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() => selectedIndex = 2);
                                  },
                                ),

                                ListTile(
                                  selected: selectedIndex == 3,
                                  selectedTileColor: Colors.blue,
                                  leading: Icon(Icons.quiz, color: Colors.red),
                                  title: Text(
                                    "Quiz Results",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() => selectedIndex = 3);
                                  },
                                ),

                                ListTile(
                                  selected: selectedIndex == 4,
                                  selectedTileColor: Colors.blue,
                                  leading: Icon(
                                    Icons.bubble_chart,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    "Simulator",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() => selectedIndex = 4);
                                  },
                                ),

                                ListTile(
                                  selected: selectedIndex == 5,
                                  selectedTileColor: Colors.blue,
                                  leading: Icon(
                                    Icons.logout,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  title: Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () async {
                                    bool? shouldLogout = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final isDark =
                                            Theme.of(context).brightness ==
                                            Brightness.dark;

                                        return AlertDialog(
                                          backgroundColor: isDark
                                              ? Colors.grey[900]
                                              : Colors.white,
                                          title: Text(
                                            "Confirm Logout",
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          content: Text(
                                            "Are you sure you want to logout from your account?",
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white70
                                                  : Colors.black87,
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            Adminlogin(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: Text("Logout"),
                                                ),
                                                Spacer(flex: 1),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    textStyle: TextStyle(
                                                      color: isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (shouldLogout == true) {
                                      await _signOutUser();
                                      if (!mounted) return;
                                      Get.offAll(() => SplashScreen());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              // RIGHT MAIN CONTENT
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? BackgroundImageLight
                          : BackgroundImageDark,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Center(child: pages[selectedIndex]),
                  ],
                ),
              ),
            ],
          ),
          // ALWAYS VISIBLE MENU BUTTON top-left
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              icon: Icon(Icons.menu, size: 25, color: Colors.black),
              onPressed: () {
                setState(() {
                  isSidebarVisible = !isSidebarVisible;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
