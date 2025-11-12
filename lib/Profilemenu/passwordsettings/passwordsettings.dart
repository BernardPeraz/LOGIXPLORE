import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/passwordsettings/passwordback/passwordcontrollers.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';

class Passwordsettings extends StatefulWidget {
  const Passwordsettings({super.key});

  @override
  State<Passwordsettings> createState() => _PasswordsettingsState();
}

class _PasswordsettingsState extends State<Passwordsettings> {
  final ValueNotifier<bool> repeatPasswordVisible = ValueNotifier(false);
  final currentPassword =
      ''; // TODO: connect to your current password TextFormField
  final newPassword = ''; // TODO: connect to new password TextFormField
  final repeatPassword = '';

  bool _passwordVisible = false;
  bool passwordVisible = false;
  Map<String, String?> fieldErrors = {};

  void togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
        title: Text(
          "PASSWORD SETTINGS",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 1,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 16.0)),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Get.back();
                if (mounted) {
                  setState(() {
                    passwordStrengthNotifier.value = PasswordResult(
                      PasswordStrength.empty,
                      0.0,
                      "",
                    );
                  });
                }
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? BackgroundImageLight
                : BackgroundImageDark,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    width: 450,
                    height: 510,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A609C).withValues(alpha: 0.66),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'CHANGE PASSWORD',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 34,
                          ),
                        ),
                        SizedBox(height: 69),
                        ValueListenableBuilder(
                          valueListenable: ValueNotifier<bool>(
                            _passwordVisible,
                          ),
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: currentPasswordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: "Current Password",
                                hintText: "Current Password",
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: togglePasswordVisibility,
                                ),
                                enabledBorder: TInputBorders.enabled,
                                focusedBorder: TInputBorders.focused,
                                errorBorder: TInputBorders.error,
                                focusedErrorBorder: TInputBorders.focusedError,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        ValueListenableBuilder(
                          valueListenable: ValueNotifier<bool>(passwordVisible),
                          builder: (context, value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: newPasswordController,
                                  obscureText: !passwordVisible,
                                  maxLength: 20,
                                  onChanged: (pdw) {
                                    // para ma-update real-time yung indicator
                                    final result = evaluatePassword(pdw);
                                    passwordStrengthNotifier.value =
                                        result; // see note below
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
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 33, 149, 243),
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 33, 149, 243),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                                ValueListenableBuilder<PasswordResult>(
                                  valueListenable: passwordStrengthNotifier,
                                  builder: (context, result, _) {
                                    if (result.strength ==
                                        PasswordStrength.empty) {
                                      return const SizedBox.shrink();
                                    }
                                    Color color;
                                    switch (result.strength) {
                                      case PasswordStrength.short:
                                        color = Colors.red;
                                      case PasswordStrength.veryWeak:
                                        color = const Color.fromARGB(
                                          255,
                                          237,
                                          77,
                                          66,
                                        );
                                        break;
                                      case PasswordStrength.medium:
                                        color = Colors.orange;
                                        break;
                                      case PasswordStrength.strong:
                                        color = const Color.fromARGB(
                                          255,
                                          0,
                                          183,
                                          6,
                                        );
                                        break;
                                      default:
                                        color = Colors.grey;
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LinearProgressIndicator(
                                          value: result.score,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                color,
                                              ),
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
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 30),

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
                                    value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: toggleRepeatPasswordVisibility,
                                ),
                                errorText: fieldErrors['repeatPassword'],
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      0,
                                      33,
                                      149,
                                      243,
                                    ),
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      0,
                                      33,
                                      149,
                                      243,
                                    ),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 45),

                        Center(
                          child: SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {
                                changePassword(
                                  context: context,
                                  currentPassword: currentPasswordController
                                      .text
                                      .trim(),
                                  newPassword: newPasswordController.text
                                      .trim(),
                                  repeatPassword: repeaatPasswordController.text
                                      .trim(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  149,
                                  0,
                                ),
                                foregroundColor: const Color.fromARGB(
                                  255,
                                  0,
                                  0,
                                  0,
                                ),
                                minimumSize: const Size(double.infinity, 52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
