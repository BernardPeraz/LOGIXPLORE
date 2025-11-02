import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> changeProfilePicture(BuildContext context) async {
  final supabase = Supabase.instance.client;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final picker = ImagePicker();

  if (firebaseUser == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Please log in first')));
    return;
  }

  try {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final fileName =
        '${firebaseUser.uid}_${DateTime.now().millisecondsSinceEpoch}${path.extension(pickedFile.path)}';

    if (kIsWeb) {
      // WEB — read bytes
      final fileBytes = await pickedFile.readAsBytes();
      await supabase.storage
          .from('profile_pics')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );
    } else {
      // MOBILE — use File()
      final file = File(pickedFile.path);
      await supabase.storage
          .from('profile_pics')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));
    }

    final publicUrl = supabase.storage
        .from('profile_pics')
        .getPublicUrl(fileName);

    await supabase.from('profiles').upsert({
      'id': firebaseUser.uid,
      'email': firebaseUser.email,
      'avatar_url': publicUrl,
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile picture updated!')));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}
