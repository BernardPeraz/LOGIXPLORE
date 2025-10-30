import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen_website.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/bodytext.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/imagecontainer.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/scopecontainer.dart';

class Landingdesktop extends StatefulWidget {
  // Pinalitan ko to StatefulWidget para magkaroon ng loading state
  const Landingdesktop({super.key});

  @override
  State<Landingdesktop> createState() => _LandingdesktopState();
}

class _LandingdesktopState extends State<Landingdesktop> {
  // Dito idedeklara yung loading state
  bool _isLoading = false;

  // Eto yung function para sa pagpunta sa sign up
  void _goToSignUp() {
    setState(() {
      _isLoading = true; // Magpapakita ng white screen
    });

    // After 2 seconds, babalik sa normal
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      // Dito ilalagay yung navigation papuntang sign up page
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
    });
  }

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
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(101, 33),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('About'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              _goToSignUp();
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.to(
                  () => const SignupScreen(),
                ); // Navigate to SignupScreen after delay
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
            child: const Text('Register'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              _goToSignUp();
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.to(
                  () => const LoginScreen(),
                ); // Navigate to SignupScreen after delay
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
            child: const Text('Sign In'),
          ),
          const SizedBox(width: 30),
        ],
      ),
      // Dito yung condition para sa white screen loading
      body: _isLoading
          ? Container(
              color: Colors.white, // Pure white background
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(), // Loading spinner
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
                          ScopeContainer(0, 20, 9, "!ST SCOPE HAHAHA", false),
                          const SizedBox(height: 10),
                          ScopeContainer(3, 20, 6, "", false),
                          const SizedBox(height: 10),
                          ScopeContainer(6, 20, 3, "", false),
                          const SizedBox(height: 10),
                          ScopeContainer(9, 20, 0, "", false),
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
