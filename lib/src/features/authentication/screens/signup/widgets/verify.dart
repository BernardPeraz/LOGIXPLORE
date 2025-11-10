import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/loadingwidgget/loadingscreen.dart';

class VerificationDialog extends StatefulWidget {
  final String otp; // this is the correct OTP
  const VerificationDialog({super.key, required this.otp});

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  String? errorMessage;

  String getEnteredOtp() {
    return otpControllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dialogWidth = screenWidth * 0.85;
    if (dialogWidth > 400) dialogWidth = 400;

    final ScrollController verticalController = ScrollController();
    final ScrollController horizontalController = ScrollController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 400),
        child: Scrollbar(
          controller: verticalController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: verticalController,
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter Verification Code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Please enter the 6-digit code sent to your email/phone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),

                const SizedBox(height: 18),

                Scrollbar(
                  controller: horizontalController,
                  thumbVisibility: true,
                  notificationPredicate: (notif) =>
                      notif.metrics.axis == Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(6, (index) {
                        double otpWidth = dialogWidth / 9;
                        if (otpWidth < 35) otpWidth = 35;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: SizedBox(
                            width: otpWidth,
                            child: TextField(
                              controller: otpControllers[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: errorMessage != null
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),

                const SizedBox(height: 18),

                ElevatedButton(
                  onPressed: () async {
                    final enteredOtp = getEnteredOtp();

                    if (enteredOtp.length < 6) {
                      setState(
                        () => errorMessage = "Incomplete verification code.",
                      );
                      return;
                    }

                    if (enteredOtp != widget.otp) {
                      setState(
                        () => errorMessage = "Incorrect verification code.",
                      );
                      return;
                    }

                    setState(() => errorMessage = null);

                    await showLoadingBeforeDialog(context);

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
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(dialogWidth * 0.4, 40),
                  ),
                  child: const Text("Verify"),
                ),

                TextButton(onPressed: () {}, child: const Text("Resend Code")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
