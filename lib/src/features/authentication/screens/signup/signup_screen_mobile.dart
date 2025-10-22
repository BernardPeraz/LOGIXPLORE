import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BackgroundImageLight),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  const FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: "Get On Board!",
                    subTitle: "Create your profile to start your journey.",
                  ),
                  const SignUpFormWidget(),
                  const Text("OR"),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        bool isLoggedIn = await login(context);
                        if (isLoggedIn) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        }
                      },
                      icon: const Image(
                        image: AssetImage(tGoogleLogoimage),
                        width: 20,
                      ),
                      label: const Text("SIGN IN WITH GOOGLE"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user cannot dismiss
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      await Future.delayed(const Duration(seconds: 2));

                      Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an Account? ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(text: "LOGIN"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> login(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return FirebaseAuth.instance.currentUser != null;
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          print('Sign-in cancelled');
          return false;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        return FirebaseAuth.instance.currentUser != null;
      }
    } catch (e) {
      print("Google Sign-In Error: $e");

      return false;
    }
  }
}
