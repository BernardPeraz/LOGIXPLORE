import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';

class WebsiteLoginScreen extends StatelessWidget {
  const WebsiteLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FormHeaderWidget(
                              image: tWelcomeScreenImage,
                              title: "Welcome Back,",
                              subTitle:
                                  "Learn Logic Gates much faster, easier, more convinient",
                            ),

                            const LoginForm(),
                            LoginFooterWidget(),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                              Get.offAll(Landingpagee());
                              void resetFormFields({
                                required VoidCallback updateUI,
                              }) {
                                firstNameController.clear();
                                lastNameController.clear();
                                usernameController.clear();
                                emailController.clear();
                                mobileNumberController.clear();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
