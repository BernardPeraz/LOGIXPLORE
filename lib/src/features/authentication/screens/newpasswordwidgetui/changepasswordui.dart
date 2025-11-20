import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/passwordsettings/passwordback/passwordcontrollers.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/welcome/landingpage.dart';

class Changepasswordui extends StatefulWidget {
  final String email;
  const Changepasswordui({super.key, required this.email});

  @override
  State<Changepasswordui> createState() => _ChangepassworduiState();
}

class _ChangepassworduiState extends State<Changepasswordui> {
  final ValueNotifier<bool> repeatPasswordVisible = ValueNotifier(false);
  bool passwordVisible = false;

  Map<String, String?> fieldErrors = {};
  void toggleNewPasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleRepeatPasswordVisibility() {
    repeatPasswordVisible.value = !repeatPasswordVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    // RESPONSIVE VARIABLES
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // For mobile, text is smaller; for desktop, text is larger
    double titleSize = screenWidth < 600 ? 18 : 22;
    double textFieldFont = screenWidth < 600 ? 14 : 18;
    double containerWidth = screenWidth < 600 ? screenWidth * 0.85 : 400;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png'),
        title: Text(
          "LOGIXPLORE",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      //CENTER THE WHOLE FORM PROPERLY
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              "assets/images/background_images/light-bg-image.jpg",
            ),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 80, 158, 222),
                borderRadius: BorderRadius.circular(23),
              ),
              height: 450,

              padding: EdgeInsets.all(20),
              width: containerWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TITLE
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 70),

                  // NEW PASSWORD FIELD
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: !passwordVisible,
                    maxLength: 20,
                    onChanged: (pdw) {
                      // para ma-update real-time yung indicator
                      final result = evaluatePassword(pdw);
                      passwordStrengthNotifier.value = result;
                    },
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      counterText: '',
                      border: InputBorder.none,
                      filled: true,
                      hintText:
                          'Must have 1 uppercase, lowercase, number, and special character',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: toggleNewPasswordVisibility,
                      ),
                      errorText: fieldErrors['password'],
                      enabledBorder: TInputBorders.enabled,
                      focusedBorder: TInputBorders.focused,
                      errorBorder: TInputBorders.error,
                      focusedErrorBorder: TInputBorders.focusedError,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder<PasswordResult>(
                      valueListenable: passwordStrengthNotifier,
                      builder: (context, result, _) {
                        if (result.strength == PasswordStrength.empty) {
                          return const SizedBox.shrink();
                        }
                        Color color;
                        switch (result.strength) {
                          case PasswordStrength.short:
                            color = Colors.red;
                          case PasswordStrength.veryWeak:
                            color = const Color.fromARGB(255, 237, 77, 66);
                            break;
                          case PasswordStrength.medium:
                            color = Colors.orange;
                            break;
                          case PasswordStrength.strong:
                            color = const Color.fromARGB(255, 0, 183, 6);
                            break;
                          default:
                            color = Colors.grey;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              value: result.score,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                              minHeight: 6,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.label,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // REPEAT PASSWORD FIELD
                  ValueListenableBuilder(
                    valueListenable: repeatPasswordVisible,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: repeaatPasswordController,
                        obscureText: !value,
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

                  SizedBox(height: 40),

                  // ===== BUTTON =====
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        final newPass = newPasswordController.text.trim();
                        final repeatPass = repeaatPasswordController.text
                            .trim();

                        setState(() {
                          fieldErrors.clear();
                        });

                        if (newPass.isEmpty || repeatPass.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill in all fields."),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }

                        if (newPass != repeatPass) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Passwords do not match."),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }

                        final result = evaluatePassword(newPass);
                        if (result.strength == PasswordStrength.short ||
                            result.strength == PasswordStrength.veryWeak) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Password is too weak."),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }

                        try {
                          final query = await FirebaseFirestore.instance
                              .collection("users")
                              .where("Email", isEqualTo: widget.email)
                              .get();

                          if (query.docs.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Account not found."),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ),
                            );
                            return;
                          }

                          //  GET OLD PASSWORD FROM FIRESTORE
                          final oldPassword = query.docs.first["Password"];

                          // REAUTHENTICATE USER USING OLD PASSWORD
                          final cred = EmailAuthProvider.credential(
                            email: widget.email,
                            password: oldPassword,
                          );

                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await user.reauthenticateWithCredential(cred);

                            //  UPDATE AUTH PASSWORD
                            await user.updatePassword(newPass);
                          } else {
                            //  If no user is logged in, sign them in temporarily
                            final signInUser = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: widget.email,
                                  password: oldPassword,
                                );

                            await signInUser.user!.reauthenticateWithCredential(
                              cred,
                            );

                            //  Update Auth password
                            await signInUser.user!.updatePassword(newPass);
                          }

                          // Update Firestore password (your existing code)
                          await query.docs.first.reference.update({
                            "Password": newPass,
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Password updated successfully!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          await Future.delayed(Duration(milliseconds: 800));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Landingpagee(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to update: $e"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),

                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Change",
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 14 : 18,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
