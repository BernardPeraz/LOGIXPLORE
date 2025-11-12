import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

final currentPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final repeaatPasswordController = TextEditingController();
Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
  required String repeatPassword,
  required BuildContext context,
}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No user is currently signed in.')),
    );
    return;
  }

  // 🔹 1. Basic validation
  if (currentPassword.isEmpty ||
      newPassword.isEmpty ||
      repeatPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in all password fields.')),
    );
    return;
  }

  if (newPassword != repeatPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New passwords do not match.')),
    );
    return;
  }

  // 🔹 SHOW LOADING
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    // 🔹 2. Reauthenticate the user first
    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred);

    // 🔹 3. Update password in Firebase
    await user.updatePassword(newPassword);

    if (Navigator.canPop(context)) Navigator.pop(context); // close loading

    //  SUCCESS DIALOG
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Password Changed',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your password has been successfully changed.',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );

    // 🔸 Clear text fields
    currentPasswordController.clear();
    newPasswordController.clear();
    repeaatPasswordController.clear();
    passwordStrengthNotifier.value = PasswordResult(
      PasswordStrength.empty,
      0.0,
      "",
    );
    Navigator.pop(context);

    Get.offAll(() => const Dashboard());
  } on FirebaseAuthException catch (e) {
    if (Navigator.canPop(context)) Navigator.pop(context); // close loading

    String error = 'Error updating password.';
    if (e.code == 'wrong-password') {
      error = 'Incorrect current password.';
    } else if (e.code == 'weak-password') {
      error = 'New password is too weak.';
    } else if (e.code == 'requires-recent-login') {
      error = 'Please re-login before changing your password.';
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Failed'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    if (Navigator.canPop(context)) Navigator.pop(context); // close loading

    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Unexpected Error'),
        content: Text('Something went wrong. Please try again.'),
      ),
    );
  }
}
