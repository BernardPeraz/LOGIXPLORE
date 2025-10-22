import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailOrNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final ValueNotifier<bool> repeatPasswordVisible = ValueNotifier(false);
  bool _passwordVisible = false;

  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  Future<void> _login() async {
    final input = emailOrNumberController.text.trim();
    final password = passwordController.text.trim();

    // Reset errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Validation for empty fields
    if (input.isEmpty || password.isEmpty) {
      setState(() {
        if (input.isEmpty) {
          _emailError = "Please enter your email or phone number.";
        }
        if (password.isEmpty) _passwordError = "Please enter your password.";
      });

      // Auto-remove error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _emailError = null;
          _passwordError = null;
        });
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? email;

      if (input.contains('@')) {
        email = input;
      } else if (input.startsWith('09') || input.startsWith('+639')) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('Mobile Number', isEqualTo: input)
            .get();

        if (snapshot.docs.isNotEmpty) {
          email = snapshot.docs.first['Email'];
        } else {
          throw FirebaseAuthException(
            code: 'user-not-found',
            message: 'Phone number not registered.',
          );
        }
      } else {
        throw FirebaseAuthException(
          code: 'invalid-input',
          message: 'Enter a valid email or phone number.',
        );
      }

      await _auth.signInWithEmailAndPassword(email: email!, password: password);

      // If success go to dashboard
      setState(() {
        _isLoading = false;
      });
      Get.off(() => const Dashboard());
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;

        if (e.code == 'user-not-found') {
          _emailError = 'Account not found. Please register first.';
        } else if (e.code == 'wrong-password') {
          _passwordError = 'Incorrect password. Try again.';
        } else if (e.code == 'invalid-email') {
          _emailError = 'Invalid email format.';
        } else if (e.code == 'invalid-input') {
          _emailError = 'Please enter a valid email or phone number.';
        } else {
          _emailError = 'Login failed. Please try again.';
        }
      });

      // Auto-hide errors after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _emailError = null;
            _passwordError = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _emailError = 'Something went wrong. Please try again.';
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _emailError = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailOrNumberController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Email or Phone Number",
                hintText: "Email or Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            if (_emailError != null) ...[
              const SizedBox(height: 5),
              Text(
                _emailError!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
            const SizedBox(height: tFormHeight),
            ValueListenableBuilder(
              valueListenable: passwordVisible,
              builder: (context, value, child) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: "Password",
                    hintText: "Password",

                    border: const OutlineInputBorder(),

                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible =
                              !_passwordVisible; // 👁️ toggle visibility
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            if (_passwordError != null) ...[
              const SizedBox(height: 5),
              Text(
                _passwordError!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
            const SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,

                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("LOGIN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
