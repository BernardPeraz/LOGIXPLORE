import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class UploadButton extends StatefulWidget {
  /// Pass the specific lesson list from the parent page
  final List<Map<String, dynamic>> targetLessonList;

  const UploadButton({super.key, required this.targetLessonList});

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  @override
  Widget build(BuildContext context) {
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

  void _pickFileAndAdd(BuildContext context) {
    final uploadInput = html.FileUploadInputElement()..accept = '.pdf';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final tempUrl = html.Url.createObjectUrl(file);

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
                    _discardFile(tempUrl, file.name);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Discard",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _uploadFile(tempUrl, file.name);
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
    });
  }

  void _uploadFile(String url, String fileName) {
    setState(() {
      // Add to the specific lesson list passed from parent
      widget.targetLessonList.add({
        'pdfPath': url,
        'title': fileName,
        'progress': 0.0,
      });
      print("Uploaded to selected lessons list: $fileName");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File '$fileName' uploaded successfully!"),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _discardFile(String url, String fileName) {
    html.Url.revokeObjectUrl(url);
    print("File discarded: $fileName");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("File '$fileName' was discarded."),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
