import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/conditionforgetpassword/emailservice.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    String _generateVerificationCode() {
      return (100000 + Random().nextInt(900000)).toString();
    }

    // IDADAGDAG LANG - Function para mag-send ng code sa email
    void sendCodeToEmail() {
      String email = _emailController.text
          .trim(); // Kunin ang email mula sa text field

      if (email.isNotEmpty) {
        // DITO MAGSE-SEND NG CODE SA EMAIL NA ITO
        print('Magse-send ng verification code sa: $email');

        // DITO ILALAGAY ANG LOGIC PARA:
        // 1. Mag-generate ng verification code
        // 2. Mag-send ng code sa email na: $email
        // 3. I-save ang code sa database
        // 4. I-pass ang email sa OTP screen kung kailangan

        // Mag-navigate sa OTP screen
        Get.to(() => const OTPScreen());
      } else {
        // Kung walang email na nilagay
        print('Pakilagay ang email address');
        // Pwede ring mag-show ng snackbar o alert dito
      }
    }

    void _sendCodeToEmail() {
      String email = _emailController.text.trim();

      if (email.isNotEmpty) {
        // Generate code
        String verificationCode = _generateVerificationCode();

        // Mag-send ng code gamit ang EmailService
        EmailService.sendVerificationCode(email, verificationCode);

        Get.to(() => const OTPScreen());
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                SizedBox(height: tDefaultSize * 4),
                FormHeaderWidget(
                  image: tForgetPasswordImage,
                  title: "Forgot Password",
                  subTitle:
                      "select one of the options given below to reset your password",
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: tFormHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text("Email"),
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              sendCodeToEmail, // IDADAGDAG LANG - palitan ang direct navigation
                          child: Text("Next"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
