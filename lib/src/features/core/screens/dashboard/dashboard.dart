import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profile.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/profilesettings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard_block.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                    _buildPopupMenuItem(
                      icon: Icons.person,
                      text: "Profile Settings",
                      isDark: isDark,
                      onTap: () {
                        _hidePopupMenu();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileSettings(),
                          ),
                        );
                      },
                    ),
                    _buildPopupMenuItem(
                      icon: Icons.settings,
                      text: "Password Settings",
                      isDark: isDark,
                      onTap: () {
                        _hidePopupMenu();
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
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // Cancel
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.blue[300]
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirm
                                  },
                                  child: Text("Logout"),
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
              CircleAvatar(
                radius: 17,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : const AssetImage('assets/logo/avatar.png')
                          as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName?.isNotEmpty == true
                          ? user.displayName!
                          : 'User',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  Future<void> _signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

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
          ProfileMenuBox(),
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
                      text: "AND",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[400],
                      text: "NAND",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[500],
                      text: "OR",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[600],
                      text: "NOR",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[700],
                      text: "NOT",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[800],
                      text: "XOR",
                      image: "assets/logo/or.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[800],
                      text: "XNOR",
                      image: "assets/logo/annd.jpg",
                    ),
                    buildBlock(
                      width: blockWidth,
                      color: Colors.blue[800],
                      text: "BUFFER",
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

  @override
  void dispose() {
    _hidePopupMenu();
    super.dispose();
  }
}
