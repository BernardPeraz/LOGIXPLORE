import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class WebsiteSignupScreen extends StatefulWidget {
  const WebsiteSignupScreen({super.key});

  @override
  State<WebsiteSignupScreen> createState() => _WebsiteSignupScreenState();
}

class _WebsiteSignupScreenState extends State<WebsiteSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundImageLight),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(child: Image(image: AssetImage(tSplashImage))),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xFF4A609C).withValues(alpha: 0.66),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(tDefaultSize),
                        child: Column(
                          children: [
                            FormHeaderWidget(
                              image: tWelcomeScreenImage,
                              title: "Get On Board!",
                              subTitle:
                                  "Create your profile to start your Journey.",
                            ),

                            SignUpFormWidget(),
                            Column(
                              children: [
                                const Text("OR"),
                                const SizedBox(height: 20),
                                IconButton(
                                  onPressed: () async {
                                    bool isLoggedIn = await login(context);
                                    if (isLoggedIn) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Dashboard(),
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
                                SizedBox(height: 15),

                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // user cannot dismiss
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );

                                    Navigator.of(context).pop();

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
                                        color: const Color.fromARGB(
                                          255,
                                          25,
                                          17,
                                          255,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),

                                      children: [
                                        TextSpan(
                                          text: "Already have an Account? ",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        TextSpan(text: "LOGIN"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20, // 20 pixels from the top
                      right: 20, // 20 pixels from the right
                      child: GestureDetector(
                        onTap: () {
                          // STEP 4: Navigation functionality - magse-close ang screen kapag pinindot
                          Navigator.of(context).pop();
                          resetFormFields(updateUI: () {});
                        },
                        child: Container(
                          width: 40, // Fixed width
                          height: 40, // Fixed height
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
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              Navigator.of(context).pop();
                              resetFormFields(
                                updateUI: () {
                                  setState(() {}); // Force UI update
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
