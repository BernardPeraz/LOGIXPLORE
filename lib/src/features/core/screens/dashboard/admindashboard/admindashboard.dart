import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/adminlogin/adminlogin.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  Future<void> _signOutUser() async {
    FirebaseAuth.instance.currentUser?.email;
    await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.currentUser;
    Get.offAll(Adminlogin());
  }

  int selectedIndex = 0;

  final List<Widget> pages = [
    Center(child: Text("Dashboard Overview", style: TextStyle(fontSize: 22))),
    Center(child: Text("Student Progress", style: TextStyle(fontSize: 22))),
    Center(child: Text("User Management", style: TextStyle(fontSize: 22))),
    Center(child: Text("Settings", style: TextStyle(fontSize: 22))),
    Center(child: Text("Logging out...", style: TextStyle(fontSize: 22))),
  ];

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(0, 0, 0, 0),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Tooltip(
                message: 'Simulator',
                child: Image.asset(
                  'assets/logo/iconbutton.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(0, 247, 246, 241),
            ),
            child: IconButton(
              onPressed: () {
                ThemeData theme = Theme.of(context);
                bool isDark = theme.brightness == Brightness.light;
                Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),

      // ----------------------------------------------------------
      // BODY WITH PERMANENT LEFT SIDEBAR
      // ----------------------------------------------------------
      body: Row(
        children: [
          // ------------------------------
          // LEFT FIXED SIDEBAR
          // ------------------------------
          Container(
            width: 200,
            color: Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Student Progress",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),

                // ---------- MENU ITEM 2 ----------
                ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: const Text("Exercises"),
                  onTap: () {
                    setState(() => selectedIndex = 1);
                  },
                ),

                // ---------- MENU ITEM 3 ----------
                ListTile(
                  leading: Icon(Icons.people),
                  title: const Text("Quizzes"),
                  onTap: () {
                    setState(() => selectedIndex = 2);
                  },
                ),

                // ---------- MENU ITEM 4 ----------
                ListTile(
                  leading: Icon(Icons.settings),
                  title: const Text("Simulator"),
                  onTap: () {
                    setState(() => selectedIndex = 3);
                  },
                ),

                // ---------- LOGOUT ----------
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    bool? shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;

                        return AlertDialog(
                          backgroundColor: isDark
                              ? Colors.grey[900]
                              : Colors.white,
                          title: Text(
                            "Confirm Logout",
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to logout from your account?",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logout button sa left
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(color: Colors.transparent),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirm
                                  },
                                  child: Text("Logout"),
                                ),
                                Spacer(flex: 1),
                                // Cancel button sa right
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    textStyle: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back(); // Confirm
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
          ),

          // ------------------------------
          // RIGHT MAIN CONTENT (changes on menu click)
          // ------------------------------
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

                // 🔥 Dynamic Center Content
                Center(child: pages[selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
