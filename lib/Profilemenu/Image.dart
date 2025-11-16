import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> changeProfilePicture(BuildContext context) async {
  final supabase = Supabase.instance.client;
  final picker = ImagePicker();
  final firebaseUser = fb.FirebaseAuth.instance.currentUser;

  // Pick image from gallery
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return;

  final fileName =
      '${firebaseUser?.uid ?? "guest"}_${DateTime.now().millisecondsSinceEpoch}.jpg';

  try {
    // Upload to Supabase Storage
    if (kIsWeb) {
      final bytes = await pickedFile.readAsBytes();
      await supabase.storage.from('avatars').uploadBinary(fileName, bytes);
    } else {
      final file = File(pickedFile.path);
      await supabase.storage.from('avatars').upload(fileName, file);
    }

    // Get public URL
    final publicUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

    // Save to Firestore
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .update({'profileImage': publicUrl});
    }
  } catch (e) {}
}
