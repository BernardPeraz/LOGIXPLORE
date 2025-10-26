import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> uploadFile(File file, String bucketName, String path) async {
    try {
      final response = await supabase.storage
          .from(bucketName)
          .upload(path, file);

      if (response.isNotEmpty) {
        final publicUrl = supabase.storage.from(bucketName).getPublicUrl(path);
        return publicUrl;
      }
    } catch (e) {
      print('Upload failed: $e');
    }
    return null;
  }
}
