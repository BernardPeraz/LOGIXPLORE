import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/signup_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

final firstNameeController = TextEditingController();
final lastNameeController = TextEditingController();
final usernameeController = TextEditingController();
final emaiilController = TextEditingController();
Future<void> updateUserProfile({
  required BuildContext context,
  required String firstName,
  required String lastName,
  required String username,
}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No user is currently signed in.')),
    );
    return;
  }

  if (firstName.isEmpty || lastName.isEmpty || username.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('All fields are required.')));
    return;
  }

  // 🔹 Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    // 🔹 Update Firestore user document
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'First Name': firstName.trim(),
      'Last Name': lastName.trim(),
      'Username': username.trim(),
    });

    //  Optional: update Firebase display name (Auth profile)
    await user.updateDisplayName('$firstName $lastName');

    //  Close loading dialog
    if (Navigator.canPop(context)) Navigator.pop(context);

    // Show success dialog
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Profile Updated',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your profile information has been successfully updated.',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                firstNameeController.clear();
                lastNameeController.clear();
                usernameeController.clear();
                emaiilController.clear();
                Get.offAll(() => const Dashboard());
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    if (Navigator.canPop(context)) Navigator.pop(context); // close loading

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update Failed'),
        content: Text('Something went wrong: $e'),
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
