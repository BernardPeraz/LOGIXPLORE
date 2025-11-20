import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/newpasswordwidgetui/changepasswordui.dart';

class OTPScreen extends StatefulWidget {
  final String otp;
  final String email;

  const OTPScreen({super.key, required this.otp, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredCode = "";

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CO\nDE",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),
            ),
            Text(
              "VERIFICATION",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Text(
              "We sent a verification code to \n${widget.email}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // OTP BOXES
            OtpTextField(
              numberOfFields: 6,
              showFieldAsBox: true,
              filled: true,
              fillColor: Colors.black.withOpacity(0.1),
              onSubmit: (code) {
                enteredCode = code;
              },
            ),

            const SizedBox(height: 20),

            // NEXT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Next"),
                onPressed: () {
                  // 1. Check if complete (6 digits)
                  if (enteredCode.length != 6) {
                    showError("Please enter all 6 digits.");
                    return;
                  }

                  // 2. Check if OTP matches
                  if (enteredCode != widget.otp) {
                    showError("Incorrect verification code.");
                    return;
                  }

                  // 3. MATCH → GO TO CHANGE PASSWORD
                  Get.to(() => Changepasswordui(email: widget.email));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
