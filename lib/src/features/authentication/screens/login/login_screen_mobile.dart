import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    bool isWideScreen = screen > 800;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BackgroundImageLight),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xFF4A609C).withValues(alpha: 0.66),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: isWideScreen
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left side (Header + Description)
                            Expanded(
                              flex: 1,
                              child: FormHeaderWidget(
                                image: tWelcomeScreenImage,
                                title: "Welcome Back,",
                                subTitle:
                                    "Learn Logic Gates much faster, easier, more convenient",
                              ),
                            ),
                            const SizedBox(width: 50),

                            // Right side (Form + Footer)
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  LoginForm(),
                                  SizedBox(height: tFormHeight),
                                  LoginFooterWidget(),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FormHeaderWidget(
                              image: tWelcomeScreenImage,
                              title: "Welcome Back,",
                              subTitle:
                                  "Learn Logic Gates much faster, easier, more convenient",
                            ),
                            const LoginForm(),
                            const LoginFooterWidget(),
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

                    void resetFormFields({required VoidCallback updateUI}) {
                      firstNameController.clear();
                      lastNameController.clear();
                      usernameController.clear();
                      mobileNumberController.clear();
                      emailController.clear();
                      passwordController.clear();
                      repeatPasswordController.clear();
                      updateUI();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
