import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/otpgenerate.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/emailjsservice.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  ForgetPasswordMailScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth > 700;

            final double formWidth = isDesktop ? 400 : 400;
            final double textFieldFont = isDesktop ? 18 : 10;
            final double buttonFont = isDesktop ? 18 : 10;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: isDesktop ? 600 : 500,
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: Column(
                        children: [
                          SizedBox(height: tDefaultSize * 3),

                          // HEADER
                          FormHeaderWidget(
                            image: tForgetPasswordImage,
                            title: "Forgot Password",
                            subTitle: "Enter your email to reset your password",
                            crossAxisAlignment: CrossAxisAlignment.center,
                            heightBetween: 25.0,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: tFormHeight + (isDesktop ? 10 : 0)),

                          SizedBox(
                            width: formWidth,
                            child: TextFormField(
                              controller: emailController,
                              maxLength: 50,
                              decoration: InputDecoration(
                                label: const Text("Email"),
                                counterText: '',
                                hintText: " Your email registered",
                                border: InputBorder.none,
                                filled: true,
                                prefixIcon: const Icon(Icons.email_outlined),

                                enabledBorder: TInputBorders.enabled,
                                focusedBorder: TInputBorders.focused,
                                errorBorder: TInputBorders.error,
                                focusedErrorBorder: TInputBorders.focusedError,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: formWidth,
                            child: ElevatedButton(
                              onPressed: () async {
                                final email = emailController.text.trim();

                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please enter your email"),
                                    ),
                                  );
                                  return;
                                }

                                final userQuery = await FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .where("Email", isEqualTo: email)
                                    .get();

                                if (userQuery.docs.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Email Not Found"),
                                      content: const Text(
                                        "The email you entered does not exist in our records.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }

                                final otp = OtpUtils.generate6Digit();

                                final sent = await EmailJsService.sendOtp(
                                  email,
                                  otp,
                                );

                                if (!sent) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                        "Failed to send verification code. Try again.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }

                                Get.to(() => OTPScreen(otp: otp, email: email));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  149,
                                  0,
                                ),
                                foregroundColor: const Color.fromARGB(
                                  255,
                                  0,
                                  0,
                                  0,
                                ),

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: buttonFont),
                              ),
                            ),
                          ),

                          SizedBox(height: isDesktop ? 60 : 20),
                        ],
                      ),
                    ),
                  ),
                ),

                /// -------------------------------
                /// FIXED CLOSE BUTTON (correct place)
                /// -------------------------------
                Positioned(
                  top: 20,
                  right: 20,
                  child: Tooltip(
                    message: 'Close page',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(125, 225, 56, 56),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            Get.offAll(Landingpagee());
                            void resetFormFields({
                              required VoidCallback updateUI,
                            }) {
                              emailController.clear();
                              updateUI();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
