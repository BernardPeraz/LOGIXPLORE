import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/login/login_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/bodytext.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/imagecontainer.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/widgetts/scopecontainer.dart';

class Landingmobile extends StatefulWidget {
  const Landingmobile({super.key});

  @override
  State<Landingmobile> createState() => _LandingmobileState();
}

class _LandingmobileState extends State<Landingmobile> {
  bool _isLoading = false;

  void _goToSignUp() {
    setState(() {
      _isLoading = true; // Magpapakita ng white screen
    });

    // After 2 seconds, babalik sa normal
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      // Dito ilalagay yung navigation papuntang sign up page
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> allButtons = ['Home', 'About', 'Sign in', 'Register'];
    List<String> reversed = allButtons.reversed.toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        List<String> visibleButtons = [];
        List<String> hiddenButtons = [];

        if (width > 655) {
          visibleButtons = allButtons.sublist(0, 3);
          hiddenButtons = allButtons.sublist(3);
        } else if (width > 530) {
          visibleButtons = allButtons.sublist(0, 2);
          hiddenButtons = allButtons.sublist(2);
        } else if (width > 460) {
          visibleButtons = allButtons.sublist(0, 1);
          hiddenButtons = allButtons.sublist(1);
        } else {
          visibleButtons = [];
          hiddenButtons = allButtons;
        }
        return Scaffold(
          appBar: AppBar(
            leading: Image.asset(
              'assets/logo/logicon.png',
              height: 9,
              width: 5,
            ),
            title: Text(
              "LOGIXPLORE",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            elevation: 1,
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            actions: [
              ...visibleButtons.map(
                (label) => Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: OutlinedButton(
                    onPressed: () {
                      if (label == 'Register') {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(
                            () => const SignupScreen(),
                          ); // Navigate to SignupScreen after delay
                        });
                      } else if (label == 'Sign in') {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(
                            () => const SignupScreen(),
                          ); // Navigate to SignupScreen after delay
                        });
                      } else if (label == 'About') {
                      } else if (label == 'Home') {}
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      backgroundColor: (label == 'Register')
                          ? Color.fromARGB(255, 255, 128, 0)
                          : Colors.black,
                      foregroundColor: (label == 'Register')
                          ? Colors.black
                          : Colors.white,
                      textStyle: TextStyle(
                        fontWeight: (label == 'Register')
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    child: Text(label),
                  ),
                ),
              ),

              if (allButtons.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black),
                    onSelected: (value) {
                      if (value == 'Register') {
                        _goToSignUp();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(
                            () => const SignupScreen(),
                          ); // Navigate to SignupScreen after delay
                        });
                      } else if (value == 'Sign in') {
                        _goToSignUp();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.to(
                            () => const LoginScreen(),
                          ); // Navigate to SignupScreen after delay
                        });
                      } else if (value == 'About') {
                      } else if (value == 'Home') {}
                      // ignore: avoid_print
                      print('$value clicked');
                      // You can handle navigation here
                    },
                    itemBuilder: (context) => hiddenButtons
                        .map(
                          (label) =>
                              PopupMenuItem(value: label, child: Text(label)),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
          body: _isLoading
              ? Container(
                  color: Colors.white, // Pure white background
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(), // Loading spinner
                        SizedBox(height: 20),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/background_images/light-bg-image.jpg",
                      ),

                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ImageContainer(
                              MediaQuery.of(context).size.width,
                              false,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            BodyText(MediaQuery.of(context).size.width, false),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.all(19),

                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              ScopeContainer(0, 20, 0, '', false),
                              SizedBox(height: 10),
                              ScopeContainer(0, 20, 0, '', false),
                              SizedBox(height: 10),
                              ScopeContainer(0, 20, 0, '', false),
                              SizedBox(height: 10),
                              ScopeContainer(0, 20, 0, '', false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
