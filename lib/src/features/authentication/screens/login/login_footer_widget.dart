import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen_website.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR", style: TextStyle(fontSize: 12)),

        SizedBox(height: tFormHeight - 20),

        SizedBox(
          width: 40,
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
        SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false, // user cannot dismiss
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );

            await Future.delayed(const Duration(seconds: 2));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(body: SignupScreen()),
              ),
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
      ],
    );
  }
}
