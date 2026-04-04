import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadButton extends StatefulWidget {
  /// Pass the specific lesson list from the parent page
  final List<Map<String, dynamic>> targetLessonList;
  final String gatesType;
  const UploadButton({
    super.key,
    required this.targetLessonList,
    required this.gatesType,
  });

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkIfAdmin();
  }

  Future<void> checkIfAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        isAdmin = false;
        isLoading = false;
      });
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('admin1')
        .where('Email', isEqualTo: user.email) // 👈 FIX
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();

      if (data['role'] == 'Admin') {
        // 👈 mas tamang check
        isAdmin = true;
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(); // habang chine-check role
    }

    if (!isAdmin) {
      return const SizedBox(); // 👈 hidden sa users
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 43,
      child: ElevatedButton(
        onPressed: () {
          _pickFileAndAdd(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          disabledBackgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          side: const BorderSide(color: Colors.transparent),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload, color: Colors.black),
            SizedBox(width: 8),
            Text(
              "Upload File",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickFileAndAdd(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      // Show the dialog with Upload / Discard options
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload PDF"),
            content: Text(
              "Do you want to upload '${file.name}' or discard it?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _discardFile(file.name, file.name);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Discard",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  _uploadFile(file);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Upload",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _uploadFile(PlatformFile file) async {
    try {
      final supabase = Supabase.instance.client;

      final bytes = file.bytes!;

      // 1. Upload to Supabase
      await supabase.storage
          .from('pdfsave')
          .uploadBinary(
            file.name,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );

      // 2. Get public URL
      final publicUrl = supabase.storage
          .from('pdfsave')
          .getPublicUrl(file.name);

      // 3. Save to Firestore
      await FirebaseFirestore.instance.collection('lessons').add({
        'title': file.name,
        'pdfPath': publicUrl,
        'progress': 0.0,
        'createdAt': FieldValue.serverTimestamp(),
        'gateType': widget.gatesType,
      });

      setState(() {
        widget.targetLessonList.add({'pdfPath': publicUrl, 'title': file.name});
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Uploaded & saved successfully!")));
    } catch (e) {
      print("Upload error: $e");
    }
  }

  void _discardFile(String url, String fileName) {
    // No action needed for file_picker
    print("File discarded: $fileName");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("File '$fileName' was discarded."),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
