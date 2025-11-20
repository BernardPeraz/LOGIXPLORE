import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/screens/signup/emailjsservice.dart';

class VerificationDialog extends StatefulWidget {
  final String otp; // this is the correct OTP
  final String email; //  added to send new OTP

  const VerificationDialog({super.key, required this.otp, required this.email});

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  String? errorMessage;
  String currentOtp = ""; //  track latest OTP
  bool isResending = false; //  true while sending new code
  int resendSeconds = 0; // cooldown timer
  Timer? resendTimer;

  @override
  void initState() {
    super.initState();
    currentOtp = widget.otp;
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    super.dispose();
  }

  String getEnteredOtp() {
    return otpControllers.map((c) => c.text).join();
  }

  //  generate new OTP
  String generateNewOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  //  start 1-minute cooldown
  void startCooldown() {
    setState(() => resendSeconds = 60);
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => resendSeconds--);
      }
    });
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
                //  Close button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    tooltip: "Close",
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),

                const Text(
                  "Enter Verification Code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Please enter the 6-digit code sent to your email.",
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
                                // clear error when user types
                                if (errorMessage != null) {
                                  setState(() => errorMessage = null);
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

                // Verify button logic
                ElevatedButton(
                  onPressed: () async {
                    final enteredOtp = getEnteredOtp();

                    if (enteredOtp.length < 6) {
                      setState(
                        () => errorMessage = "Incomplete verification code.",
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) setState(() => errorMessage = null);
                      });
                      return;
                    }

                    if (enteredOtp != currentOtp) {
                      setState(
                        () => errorMessage = "Incorrect verification code.",
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) setState(() => errorMessage = null);
                      });
                      return;
                    }

                    setState(() => errorMessage = null);
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(dialogWidth * 0.4, 40),
                  ),
                  child: const Text("Verify"),
                ),

                // RESEND BUTTON WITH COOLDOWN TIMER
                TextButton(
                  onPressed: (isResending || resendSeconds > 0)
                      ? null
                      : () async {
                          setState(() => isResending = true);

                          final newOtp = generateNewOtp();

                          final sent = await EmailJsService.sendOtp(
                            widget.email.trim(),
                            newOtp,
                          );

                          setState(() => isResending = false);

                          if (sent) {
                            currentOtp = newOtp;
                            startCooldown();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "A new verification code has been sent.",
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Failed to resend code. Try again.",
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                  child: isResending
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 8),
                            Text("Resending..."),
                          ],
                        )
                      : resendSeconds > 0
                      ? Text("Resend available in ${resendSeconds}s")
                      : const Text("Resend Code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
