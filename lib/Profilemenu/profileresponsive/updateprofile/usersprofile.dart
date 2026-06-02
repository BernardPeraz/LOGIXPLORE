import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';

final firstNameeController = TextEditingController();
final lastNameeController = TextEditingController();
final usernameeController = TextEditingController();
final emaiilController = TextEditingController();

Future<void> updateUserProfile({
  required BuildContext context,
  String? firstName,
  String? lastName,
  String? username,
}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No user is currently signed in.')),
    );
    return;
  }

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data() ?? {};

    final currentFirst = (data['First Name'] ?? '').toString().trim();
    final currentLast = (data['Last Name'] ?? '').toString().trim();
    final currentUsername = (data['Username'] ?? '').toString().trim();

    final Map<String, dynamic> updateData = {};

    void addIfChanged(String key, String? newValue, String currentValue) {
      final value = (newValue ?? '').trim();

      if (value.isNotEmpty && value != currentValue) {
        updateData[key] = value;
      }
    }

    addIfChanged('First Name', firstName, currentFirst);
    addIfChanged('Last Name', lastName, currentLast);
    addIfChanged('Username', username, currentUsername);

    if (updateData.isEmpty) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Oops!', textAlign: TextAlign.center),
          content: const Text(
            'You are currently using it. Please make changes to update your profile.',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      );

      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update(updateData);

    final newFirst = updateData['First Name'] ?? currentFirst;
    final newLast = updateData['Last Name'] ?? currentLast;

    final displayName = '$newFirst $newLast'.trim();

    if (displayName.isNotEmpty) {
      await user.updateDisplayName(displayName);
    }

    if (Navigator.canPop(context)) Navigator.pop(context);

    /// SUCCESS DIALOG
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Profile Updated', textAlign: TextAlign.center),
        content: const Text(
          'Your profile has been successfully updated.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              firstNameeController.clear();
              lastNameeController.clear();
              usernameeController.clear();
              emaiilController.clear();

              Get.offAll(() => const Dashboard());
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    if (Navigator.canPop(context)) Navigator.pop(context);

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
