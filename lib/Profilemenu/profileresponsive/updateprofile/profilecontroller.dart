import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileController {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  ///  Fetches the current user's Firestore document once
  static Future<Map<String, dynamic>?> fetchUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data();
  }

  /// Returns a real-time stream for listening to profile changes
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userProfileStream() {
    final user = _auth.currentUser;
    return _firestore.collection('users').doc(user!.uid).snapshots();
  }

  /// Updates user profile fields (like name, username, or photo)
  static Future<void> updateUserProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? username,
    String? profileImage,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is currently signed in.')),
      );
      return;
    }

    final updates = <String, dynamic>{};
    if (firstName != null) updates['First Name'] = firstName.trim();
    if (lastName != null) updates['Last Name'] = lastName.trim();
    if (username != null) updates['Username'] = username.trim();
    if (profileImage != null) updates['profileImage'] = profileImage;

    //  Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await _firestore.collection('users').doc(user.uid).update(updates);

      // Optional: Update Firebase Auth display name
      if (firstName != null && lastName != null) {
        await user.updateDisplayName('$firstName $lastName');
      }

      // Close loading
      if (Navigator.canPop(context)) Navigator.pop(context);

      //  Show success dialog
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Profile Updated',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Your profile has been successfully updated.',
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
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to update profile: $e'),
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
}
