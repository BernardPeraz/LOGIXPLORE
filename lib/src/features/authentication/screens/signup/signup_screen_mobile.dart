import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(BackgroundImageLight),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xFF4A609C).withValues(alpha: 0.66),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(tDefaultSize),
                    child: Column(
                      children: [
                        const FormHeaderWidget(
                          image: tWelcomeScreenImage,
                          title: "Get On Board!",
                          subTitle:
                              "Create your profile to start your journey.",
                        ),
                        const SignUpFormWidget(),
                        const Text("OR"),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 40,
                          child: IconButton(
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

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: BorderSide(
                                color: const Color.fromARGB(0, 0, 0, 0),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false, // user cannot dismiss
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            await Future.delayed(const Duration(seconds: 2));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: const Color.fromARGB(255, 25, 17, 255),
                                fontWeight: FontWeight.w600,
                              ),

                              children: [
                                TextSpan(
                                  text: "Already have an Account? ",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      125,
                      225,
                      56,
                      56,
                    ), // White background
                    shape: BoxShape.circle, // Circular shape
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.3,
                        ), // Fixed: changed withValues to withOpacity
                        blurRadius: 4,
                        offset: Offset(
                          0,
                          2,
                        ), // Fixed: removed extra closing brace
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Get.offAll(Landingpagee());
                      resetFormFields(updateUI: () {});
                      passwordStrengthNotifier.value = PasswordResult(
                        PasswordStrength.empty,
                        0.0,
                        "",
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> login(BuildContext context) async {
    try {
      if (kIsWeb) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) return false;

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                "email": user.email ?? "",
                "First Name": user.displayName?.split(" ").first ?? "",
                "Last Name":
                    user.displayName != null &&
                        user.displayName!.split(" ").length > 1
                    ? user.displayName!.split(" ").sublist(1).join(" ")
                    : "",
              }, SetOptions(merge: true));
        }

        return FirebaseAuth.instance.currentUser != null;
      } else {
        // 1Trigger Google Sign-In
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          print('Sign-in cancelled');
          return false;
        }

        //  Show loading while checking Firestore
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        //  Get email from Google user
        final email = googleUser.email;

        // 3️Check Firestore manually if account already exists (simple if–else)
        final existingUser = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (existingUser.docs.isNotEmpty) {
          // Account already exists (from manual registration)
          Navigator.pop(context); // close loading dialog

          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Account Already Exists'),
              content: const Text(
                'This email is already registered using Email and Password.\n\n'
                'Please log in manually instead of using Google Sign-In.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          //  Sign out from Google to cancel the login process
          await GoogleSignIn().signOut();

          return false;
        } else {
          // No duplicate found, continue Google authentication
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          Navigator.pop(context); // close loading dialog

          await FirebaseAuth.instance.signInWithCredential(credential);
          return FirebaseAuth.instance.currentUser != null;
        }
      }
    } catch (e) {
      print("Google Sign-In Error: $e");

      debugPrint("Google Sign-In cancelled (WEB): $e");

      return false;
    }
  }
}
