import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//  FUNCTION: Change Password Logic
Future<void> changePassword({
  required BuildContext context,
  required String currentPassword,
  required String newPassword,
  required String repeatPassword,
}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No user is currently signed in.')),
    );
    return;
  }

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

  try {
    //  Reauthenticate the user first
    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred);

    //  Update password
    await user.updatePassword(newPassword);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully!')),
    );
  } on FirebaseAuthException catch (e) {
    String error = 'Error updating password.';

    if (e.code == 'wrong-password') {
      error = 'Incorrect current password.';
    } else if (e.code == 'weak-password') {
      error = 'New password is too weak.';
    } else if (e.code == 'requires-recent-login') {
      error = 'Please re-login before changing your password.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An unexpected error occurred.')),
    );
  }
}
