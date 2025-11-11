import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/passwordstrengthnotifier.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/terms/policy.dart';
import 'dart:async';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/terms/termsnconditions.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

bool agreeToTerms = false;

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  String? mobileError;
  Map<String, String?> fieldErrors = {};
  Timer? _errorTimer;

  @override
  void initState() {
    super.initState();
    mobileNumberController.addListener(() {
      final input = mobileNumberController.text;
      if (mounted) {
        setState(() => fieldErrors = {input: getMobileNumberError(input)});
      }
    });
  }

  @override
  void dispose() {
    _errorTimer?.cancel();
    super.dispose();
  }

  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final ValueNotifier<bool> repeatPasswordVisible = ValueNotifier(false);
  String completePhoneNumber = "+639$mobileNumberController";

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleRepeatPasswordVisibility() {
    repeatPasswordVisible.value = !repeatPasswordVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: firstNameController,
              maxLength: 50,
              decoration: InputDecoration(
                label: const Text("First name"),
                counterText: '',
                hintText: 'First name',
                enabledBorder: TInputBorders.enabled,
                focusedBorder: TInputBorders.focused,
                errorBorder: TInputBorders.error,
                focusedErrorBorder: TInputBorders.focusedError,
                filled: true,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.person_outline),
                errorText: fieldErrors['firstName'],
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: lastNameController,
              maxLength: 30,
              decoration: InputDecoration(
                label: const Text("Last name"),
                counterText: '',
                hintText: 'Last name',
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.person_outline),
                errorText: fieldErrors['lastName'],
                enabledBorder: TInputBorders.enabled,
                focusedBorder: TInputBorders.focused,
                errorBorder: TInputBorders.error,
                focusedErrorBorder: TInputBorders.focusedError,
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: usernameController,

              maxLength: 30,
              decoration: InputDecoration(
                label: const Text("Username"),
                counterText: '',
                hintText: 'Logixplore00',
                border: InputBorder.none,

                filled: true,
                prefixIcon: const Icon(Icons.person),
                errorText: fieldErrors['username'],
                suffixIcon: IconButton(
                  icon: const Icon(Icons.autorenew_rounded), // refresh icon
                  tooltip: 'Generate username',
                  onPressed: () {
                    generateUsername();
                  },
                ),

                enabledBorder: TInputBorders.enabled,
                focusedBorder: TInputBorders.focused,
                errorBorder: TInputBorders.error,
                focusedErrorBorder: TInputBorders.focusedError,
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: emailController,
              maxLength: 30,
              decoration: InputDecoration(
                label: const Text("Email"),
                counterText: '',
                hintText: "Email",
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.email_outlined),
                errorText: fieldErrors['email'],
                enabledBorder: TInputBorders.enabled,
                focusedBorder: TInputBorders.focused,
                errorBorder: TInputBorders.error,
                focusedErrorBorder: TInputBorders.focusedError,
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: mobileNumberController,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    mobileError = getMobileNumberError(value);
                  });
                }
              },
              inputFormatters: mobileNumberInputFormatters(),
              decoration: InputDecoration(
                label: const Text("Phone Number"),
                hintText: '9948536375',
                filled: true,
                border: InputBorder.none,
                errorText: fieldErrors['mobileNumber'],
                prefixIcon: const Icon(Icons.phone),
                prefix: Padding(
                  padding: EdgeInsetsGeometry.only(right: 5.0),
                  child: Text('+63', style: TextStyle(color: Colors.black)),
                ),
                enabledBorder: TInputBorders.enabled,
                focusedBorder: TInputBorders.focused,
                errorBorder: TInputBorders.error,
                focusedErrorBorder: TInputBorders.focusedError,
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            ValueListenableBuilder(
              valueListenable: passwordVisible,
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      obscureText: !value,
                      controller: passwordController,
                      maxLength: 20,
                      onChanged: (pwd) {
                        // para ma-update real-time yung indicator
                        final result = evaluatePassword(pwd);
                        passwordStrengthNotifier.value =
                            result; // see note below
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        counterText: '',
                        border: InputBorder.none,
                        filled: true,
                        hintText:
                            'Must have 1 uppercase, lowercase, number, and special character',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                        errorText: fieldErrors['password'],
                        enabledBorder: TInputBorders.enabled,
                        focusedBorder: TInputBorders.focused,
                        errorBorder: TInputBorders.error,
                        focusedErrorBorder: TInputBorders.focusedError,
                      ),
                    ),

                    const SizedBox(height: 10),
                    PasswordStrengthWidget(notifier: passwordStrengthNotifier),
                  ],
                );
              },
            ),

            SizedBox(height: tFormHeight - 10),

            ValueListenableBuilder(
              valueListenable: repeatPasswordVisible,
              builder: (context, value, child) {
                return TextFormField(
                  obscureText: !value,
                  controller: repeatPasswordController,
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                    counterText: '',
                    border: InputBorder.none,
                    filled: true,
                    hintText:
                        'Must have 1 uppercase, lowercase, number, and special character',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        value ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: toggleRepeatPasswordVisibility,
                    ),
                    errorText: fieldErrors['repeatPassword'],
                    enabledBorder: TInputBorders.enabled,
                    focusedBorder: TInputBorders.focused,
                    errorBorder: TInputBorders.error,
                    focusedErrorBorder: TInputBorders.focusedError,
                  ),
                );
              },
            ),
            SizedBox(height: tFormHeight - 10),

            Row(
              children: [
                Checkbox(
                  value: agreeToTerms,
                  onChanged: (value) {
                    setState(() => agreeToTerms = value!);
                  },
                ),

                Expanded(
                  child: Wrap(
                    children: [
                      const Text("I agree to the "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Text(" and "),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!agreeToTerms) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              'Terms & Conditions Required',
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                              'You must agree to the Terms & Conditions before signing up.',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ),
                            ],
                          ),
                        );
                        return; // BLOCK SIGNUP
                      }
                      final errors = validateAllFields();
                      if (mounted) {
                        setState(() => fieldErrors = errors);
                      }
                      _errorTimer?.cancel();
                      if (errors.isNotEmpty) {
                        _errorTimer = Timer(const Duration(seconds: 3), () {
                          if (mounted) {
                            setState(() => fieldErrors = {});
                          }
                        });
                        return; // stop signup if invalid
                      }

                      final duplicateMessage = await checkDuplicateUser(
                        email: emailController.text.trim(),
                        mobileNumber: mobileNumberController.text.trim(),
                      );

                      if (duplicateMessage != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Duplicate Entry'),
                            content: Text(duplicateMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      Future<void> signup() async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                                'First Name': firstNameController.text.trim(),
                                'Last Name': lastNameController.text.trim(),
                                'Username': usernameController.text.trim(),
                                'Mobile Number': mobileNumberController.text
                                    .trim(),
                                'Password': passwordController.text.trim(),
                                'Email': emailController.text.trim(),
                                'Created At': Timestamp.now(),
                              });

                          Navigator.pop(context);

                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                'Registration Successful',
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                'You have been successfully registered!',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );

                          setState(() {
                            firstNameController.clear();
                            lastNameController.clear();
                            usernameController.clear();
                            mobileNumberController.clear();
                            emailController.clear();
                            passwordController.clear();
                            repeatPasswordController.clear();
                            passwordStrengthNotifier.value = PasswordResult(
                              PasswordStrength.empty,
                              0.0,
                              "",
                            );
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Landingpagee(),
                            ),
                          );
                        } catch (e) {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                'Registration Failed',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      await signup();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),

                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
