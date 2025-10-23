import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/common_widgets/form/form_header_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_form_widget.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    bool isWideScreen = screen > 800;

    return Scaffold(
      body: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
