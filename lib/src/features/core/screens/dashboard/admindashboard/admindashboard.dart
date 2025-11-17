import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/adminlogin/adminlogin.dart';
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
    StudentProgressPage(),
    Center(child: Text("User Management", style: TextStyle(fontSize: 22))),
    Center(child: Text("Settings", style: TextStyle(fontSize: 22))),
    Dashboard(),
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
                      width: 200,
                      color: const Color.fromARGB(255, 246, 185, 95),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Student Progress",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Divider(),

                          ListTile(
                            leading: Icon(Icons.bar_chart),
                            title: const Text("Dashboard"),
                            onTap: () {
                              setState(() => selectedIndex = 0);
                            },
                          ),

                          ListTile(
                            leading: Icon(Icons.people),
                            title: const Text("Quizzes"),
                            onTap: () {
                              setState(() => selectedIndex = 1);
                            },
                          ),

                          ListTile(
                            leading: Icon(Icons.settings),
                            title: const Text("Simulator"),
                            onTap: () {
                              setState(() => selectedIndex = 2);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: const Text("Lessons"),
                            onTap: () {
                              setState(() => selectedIndex = 3);
                            },
                          ),

                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
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
                                                    BorderRadius.circular(5),
                                              ),
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text("Logout"),
                                          ),
                                          Spacer(flex: 1),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                              }
                            },
                          ),
                        ],
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
