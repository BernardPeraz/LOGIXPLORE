import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/responsiveness/About/aboutus.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/bodytext.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/imagecontainer.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/scopecontainer.dart';

class Landingdesktop extends StatefulWidget {
  const Landingdesktop({super.key});

  @override
  State<Landingdesktop> createState() => _LandingdesktopState();
}

class _LandingdesktopState extends State<Landingdesktop>
    with WidgetsBindingObserver {
  bool _isLoading = false;
  bool _showMenu = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // This method is called when the screen size changes
    if (_showMenu) {
      // Use post frame callback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _showMenu = false;
          });
        }
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Tooltip(
          message: 'Welcome LogiXmate!',
          child: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(101, 33),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Home'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(101, 33),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Tooltip(message: 'About us', child: const Text('About')),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              whitescreen();
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.to(() => const SignupScreen());
              });
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(101, 33),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Tooltip(
              message: 'Create your account',
              child: const Text('Register'),
            ),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              whitescreen();
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.to(() => const LoginScreen());
              });
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(101, 33),
              backgroundColor: Color.fromARGB(255, 255, 128, 0),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Tooltip(
              message: 'Sign in your account',
              child: const Text('Sign In'),
            ),
          ),
          const SizedBox(width: 30),
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
                  opacity: 0.9,
                  colorFilter: ColorFilter.mode(
                    Colors.black,
                    BlendMode.dstATop,
                  ),
                  image: AssetImage(
                    "assets/images/background_images/light-bg-image.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          BodyText(MediaQuery.of(context).size.width, true),
                          ImageContainer(
                            MediaQuery.of(context).size.width,
                            true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ScopeContainer(
                            0,
                            20,
                            9,
                            "Understand logic gates through interaction",

                            false,
                          ),
                          const SizedBox(height: 10),
                          ScopeContainer(
                            3,
                            20,
                            6,
                            "Learn basic logic gates and their functions",
                            false,
                          ),
                          const SizedBox(height: 10),
                          ScopeContainer(
                            6,
                            20,
                            3,
                            "Build your digital logic skills step by step",
                            false,
                          ),
                          const SizedBox(height: 10),
                          ScopeContainer(
                            9,
                            20,
                            0,
                            "Explore logic operations visually",
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
  }
}
