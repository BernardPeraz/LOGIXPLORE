import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/sizes.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';
import 'dart:async';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

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
              maxLength: 15,
              decoration: InputDecoration(
                label: const Text("First Name"),
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                filled: true,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.person_outline),
                errorText: fieldErrors['firstName'],
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: lastNameController,
              maxLength: 10,
              decoration: InputDecoration(
                label: const Text("Last Name"),
                counterText: '',
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.person_outline),
                errorText: fieldErrors['lastName'],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: usernameController,
              maxLength: 10,
              decoration: InputDecoration(
                label: const Text("Username"),
                counterText: '',
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.person),
                errorText: fieldErrors['username'],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            TextFormField(
              controller: emailController,
              maxLength: 30,
              decoration: InputDecoration(
                label: const Text("E-Mail"),
                counterText: '',
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.email_outlined),
                errorText: fieldErrors['email'],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(0, 33, 149, 243),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: tFormHeight - 10),

            ValueListenableBuilder(
              valueListenable: passwordVisible,
              builder: (context, value, child) {
                return TextFormField(
                  obscureText: !value,
                  controller: passwordController,
                  maxLength: 20,
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
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
                  maxLength: 20,
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: tFormHeight - 10),

            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () async {
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

                        firstNameController.clear();
                        lastNameController.clear();
                        usernameController.clear();
                        mobileNumberController.clear();
                        emailController.clear();
                        passwordController.clear();
                        repeatPasswordController.clear();

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
          ],
        ),
      ),
    );
  }
}
