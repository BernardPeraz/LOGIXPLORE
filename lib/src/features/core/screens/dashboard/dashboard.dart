import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/masterylevel/masterwidget.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/passwordsettings/passwordsettings.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profile.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/Multipagedialog.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard_blocknavigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/whitescreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

bool _isLoading = false;

class _DashboardState extends State<Dashboard> {
  void whitescreen() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  void _showPopupMenu(BuildContext context) {
    if (_isMenuOpen) return;

    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _hidePopupMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isMenuOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    double screenWidth = MediaQuery.of(context).size.width;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 250,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(-180, 40),
          child: MouseRegion(
            onExit: (_) {
              _hidePopupMenu();
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: isDark ? Colors.grey[900] : Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (screenWidth < 600 && user != null)
                      _buildProfilePopupItem(user, isDark),
                    if (screenWidth <= 748)
                      _buildPopupMenuItem(
                        icon: Icons.dark_mode,
                        text: "Dark Mode",
                        isDark: isDark,
                        onTap: () {
                          _hidePopupMenu();
                          bool isCurrentlyDark =
                              Theme.of(context).brightness == Brightness.dark;
                          Get.changeThemeMode(
                            isCurrentlyDark ? ThemeMode.light : ThemeMode.dark,
                          );
                        },
                      ),

                    // SIMULATOR moves to menu when width <= 735
                    if (screenWidth <= 735)
                      _buildPopupMenuItem(
                        icon: Icons.computer,
                        text: "Simulator",
                        isDark: isDark,
                        onTap: () {
                          _hidePopupMenu();
                          whitescreen();
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Get.to(() => WhiteScreen());
                          });
                        },
                      ),
                    _buildPopupMenuItem(
                      icon: Icons.star,
                      text: "Mastery Level",
                      isDark: isDark,
                      onTap: () async {
                        _hidePopupMenu();
                        whitescreen();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(() => const Masterwidget());
                        });
                      },
                    ),
                    _buildPopupMenuItem(
                      icon: Icons.settings,
                      text: "Password Settings",
                      isDark: isDark,
                      onTap: () {
                        _hidePopupMenu();
                        whitescreen();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(() => const Passwordsettings());
                        });
                      },
                    ),
                    _buildPopupMenuItem(
                      icon: Icons.logout,
                      text: "Logout",
                      isDark: isDark,
                      onTap: () async {
                        _hidePopupMenu();
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
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Logout button sa left
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.transparent,
                                        ),

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).pop(true); // Confirm
                                      },
                                      child: Text("Logout"),
                                    ),
                                    Spacer(flex: 1),
                                    // Cancel button sa right
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePopupItem(User user, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _hidePopupMenu();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileSettings()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ClipOval(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    String? imageUrl;
                    if (snapshot.hasData && snapshot.data!.exists) {
                      imageUrl = snapshot.data!.data()?['profileImage'];
                    }

                    if (imageUrl != null && imageUrl.isNotEmpty) {
                      //  Show the user's profile picture
                      return Image.network(
                        imageUrl,
                        width: 38,
                        height: 40,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/logo/avatar.png',

                              fit: BoxFit.cover,
                            ),
                      );
                    } else {
                      //  Default avatar if no image found
                      return Image.asset(
                        'assets/logo/avatar.png',

                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get(),
                      builder: (context, snapshot) {
                        String displayName = user.displayName ?? 'Loading...';

                        if (snapshot.hasData && snapshot.data!.exists) {
                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final String fullName =
                              '${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}'
                                  .trim();
                          if (fullName.isNotEmpty) displayName = fullName;
                        }

                        return Text(
                          displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email ?? 'No Email Found',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenuItem({
    required IconData icon,
    required String text,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  color: isDark
                      ? Colors.grey[700]
                      : const Color.fromARGB(82, 158, 158, 158),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWelcomeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        double dialogWidth = screenWidth * 0.9;
        double dialogHeight = screenHeight * 0.75;

        dialogWidth = dialogWidth > 590 ? 590 : dialogWidth;
        dialogHeight = dialogHeight > 390 ? 390 : dialogHeight;

        return MultiPageDialog(width: dialogWidth, height: dialogHeight);
      },
    );
  }

  Future<void> _signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  void initState() {
    super.initState();

    // Auto show dialog AFTER the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double blockWidth = screenWidth > 900
        ? (screenWidth / 3) - 60
        : screenWidth > 600
        ? (screenWidth / 2) - 30
        : screenWidth - 80;

    bool moveDarkMode = screenWidth <= 748;
    bool moveSimulator = screenWidth <= 735;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
        title: Row(
          children: [
            if (screenWidth > 506)
              Text(
                "LOGIXPLORE",
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis, // para hindi mag overflow
                maxLines: 1,
              ),
            SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                _showWelcomeDialog(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5), // adjust size
                backgroundColor: Colors.yellow,
                // optional color
              ),
              child: Tooltip(
                message: "What is Logic Gates?",
                child: const Icon(
                  Icons.lightbulb, // optional icon OR text
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),

        actions: [
          if (screenWidth > 735)
            IconButton(
              onPressed: () {
                _hidePopupMenu();

                // Pupunta muna sa white screen
                Get.to(() => WhiteScreen());
              },
              icon: Container(
                padding: const EdgeInsets.all(
                  4,
                ), // spacing between image and border
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(0, 0, 0, 0),
                    width: 2,
                  ), // black border
                  shape: BoxShape
                      .circle, // or BoxShape.rectangle kung gusto mo box
                ),
                child: Tooltip(
                  message: 'Simulator',
                  child: Image.asset(
                    'assets/logo/iconbutton.png',
                    width: 40, // adjust size
                    height: 40,
                  ),
                ),
              ),
            ),
          if (screenWidth > 748)
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
                  Get.changeThemeMode(
                    isDark ? ThemeMode.dark : ThemeMode.light,
                  );
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
          Tooltip(message: 'Profile', child: ProfileMenuBox()),
          CompositedTransformTarget(
            link: _layerLink,
            child: MouseRegion(
              onEnter: (_) => _showPopupMenu(context),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {
                  if (_isMenuOpen) {
                    _hidePopupMenu();
                  } else {
                    _showPopupMenu(context);
                  }
                },
              ),
            ),
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

          // Loading Screen Overlay
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Main Content
          if (!_isLoading)
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 35,
                    runSpacing: 30,
                    children: [
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[300],
                        text: "AND",
                        image: "assets/logo/and.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[400],
                        text: "NAND",
                        image: "assets/logo/nand.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[500],
                        text: "OR",
                        image: "assets/logo/or.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[600],
                        text: "NOR",
                        image: "assets/logo/nor.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[700],
                        text: "NOT",
                        image: "assets/logo/not.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[800],
                        text: "XOR",
                        image: "assets/logo/xor.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[800],
                        text: "XNOR",
                        image: "assets/logo/xnor.png",
                        progress: 1.0,
                      ),
                      BuildBlock(
                        width: blockWidth,
                        color: Colors.blue[800],
                        text: "BUFFER",
                        image: "assets/logo/buffer.png",
                        progress: 1.0,
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

  @override
  void dispose() {
    _hidePopupMenu();
    super.dispose();
  }
}
