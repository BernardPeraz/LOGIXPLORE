import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/bodytext.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/imagecontainer.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/scopecontainer.dart';

class Landingmobile extends StatefulWidget {
  const Landingmobile({super.key});

  @override
  State<Landingmobile> createState() => _LandingmobileState();
}

class _LandingmobileState extends State<Landingmobile> {
  bool _isLoading = false;

  // Add these variables for the popup menu functionality
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  void dispose() {
    _hidePopupMenu();
    super.dispose();
  }

  // Popup Menu Functions - same functionality as in Dashboard
  void _showPopupMenu(BuildContext context, List<String> hiddenButtons) {
    if (_isMenuOpen) return;

    _overlayEntry = _createOverlayEntry(context, hiddenButtons);
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

  OverlayEntry _createOverlayEntry(
    BuildContext context,
    List<String> hiddenButtons,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(-150, 40),
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
                  children: hiddenButtons
                      .map(
                        (label) => _buildPopupMenuItem(
                          text: label,
                          isDark: isDark,
                          onTap: () {
                            _hidePopupMenu();
                            _handleMenuAction(label);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenuItem({
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
                  _getIconForLabel(text),
                  size: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                text,

                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Home':
        return Icons.home;
      case 'About':
        return Icons.info;
      case 'Sign in':
        return Icons.person;
      case 'Register':
        return Icons.app_registration;
      default:
        return Icons.menu;
    }
  }

  void _handleMenuAction(String label) {
    if (label == 'Register') {
      _goToSignUp();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.to(() => const SignupScreen());
      });
    } else if (label == 'Sign in') {
      _goToSignUp();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.to(() => const LoginScreen());
      });
    } else if (label == 'About') {
      // Handle About action
    } else if (label == 'Home') {
      // Handle Home action
    }
    print('$label clicked');
  }

  void _goToSignUp() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> allButtons = ['Home', 'About', 'Sign in', 'Register'];
    List<String> reversed = allButtons.reversed.toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        List<String> visibleButtons = [];
        List<String> hiddenButtons = [];

        if (width > 655) {
          visibleButtons = allButtons.sublist(0, 3);
          hiddenButtons = allButtons.sublist(3);
        } else if (width > 530) {
          visibleButtons = allButtons.sublist(0, 2);
          hiddenButtons = allButtons.sublist(2);
        } else if (width > 460) {
          visibleButtons = allButtons.sublist(0, 1);
          hiddenButtons = allButtons.sublist(1);
        } else {
          visibleButtons = [];
          hiddenButtons = allButtons;
        }

        return Scaffold(
          appBar: AppBar(
            leading: Image.asset(
              'assets/logo/logicon.png',
              height: 9,
              width: 5,
            ),
            title: Text(
              "LOGIXPLORE",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            elevation: 1,
            backgroundColor: const Color.fromARGB(
              142,
              221,
              217,
              217,
            ).withValues(alpha: 350),
            shadowColor: const Color.fromARGB(165, 9, 9, 9),
            bottomOpacity: BorderSide.strokeAlignOutside,
            actions: [
              ...visibleButtons.map(
                (label) => Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: OutlinedButton(
                    onPressed: () {
                      _handleMenuAction(label);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      backgroundColor: (label == 'Register')
                          ? const Color.fromARGB(255, 255, 128, 0)
                          : Colors.black,
                      foregroundColor: (label == 'Register')
                          ? Colors.black
                          : Colors.white,
                      textStyle: TextStyle(
                        fontWeight: (label == 'Register')
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    child: Text(label),
                  ),
                ),
              ),

              if (hiddenButtons.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: MouseRegion(
                      onEnter: (_) => _showPopupMenu(context, hiddenButtons),
                      child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          if (_isMenuOpen) {
                            _hidePopupMenu();
                          } else {
                            _showPopupMenu(context, hiddenButtons);
                          }
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: _isLoading
              ? Container(
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
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/background_images/light-bg-image.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ImageContainer(
                              MediaQuery.of(context).size.width,
                              false,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            BodyText(MediaQuery.of(context).size.width, false),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(19),
                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              ScopeContainer(
                                0,
                                20,
                                0,
                                'Understand logic gates through interaction',
                                false,
                              ),
                              const SizedBox(height: 10),
                              ScopeContainer(
                                0,
                                20,
                                0,
                                'Learn basic logic gates and their functions',
                                false,
                              ),
                              const SizedBox(height: 10),
                              ScopeContainer(
                                0,
                                20,
                                0,
                                'Build your digital logic skills step by step',
                                false,
                              ),
                              const SizedBox(height: 10),
                              ScopeContainer(
                                0,
                                20,
                                0,
                                'Practice with interactive circuit designs.',
                                false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
