import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/adminlogin/adminlogin.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen_website.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class LoginFooterWidget extends StatefulWidget {
  const LoginFooterWidget({super.key});

  @override
  State<LoginFooterWidget> createState() => _LoginFooterWidgetState();
}

bool _isLoading = false;

class _LoginFooterWidgetState extends State<LoginFooterWidget> {
  // ------------------------------------------
  // FULLSCREEN WHITE LOADING SCREEN FUNCTION
  // ------------------------------------------
  Future<void> _showFullScreenLoadingAndGoToAdmin(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Loading',
      barrierColor: Colors.white, // ← FULLSCREEN WHITE
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, _, __) {
        return const SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white, // ← FULLSCREEN WHITE BG
            body: Center(
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
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context, rootNavigator: true).pop();

    Get.to(() => const Adminlogin());
  }

  @override
  Widget build(BuildContext context) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR", style: TextStyle(fontSize: 12)),

        SizedBox(height: tFormHeight - 20),

        SizedBox(
          width: 40,
          child: Tooltip(
            message: 'Sign in your Google account',
            child: IconButton(
              onPressed: () async {
                bool isLoggedIn = await login(context);
                if (isLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );
                }
              },
              icon: const Image(image: AssetImage(tGoogleLogoimage), width: 20),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: const Color.fromARGB(0, 0, 0, 0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );

            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context).pop();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              text: "Dont have an Account?  ",
              children: const [
                TextSpan(
                  text: "Signup",
                  style: TextStyle(
                    color: Color.fromARGB(255, 25, 17, 255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        TextButton(
          onPressed: () {
            _showFullScreenLoadingAndGoToAdmin(context);
          },
          child: const Text(
            'Admin',
            style: TextStyle(
              color: Color.fromARGB(255, 25, 17, 255),
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
