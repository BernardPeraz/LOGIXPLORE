// mobile_layout.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/andlessons.dart';

class MobileLayout {
  static Widget build(
    BuildContext context,
    Map<String, String> lesson,
    String image, {
    VoidCallback? onStartLesson,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: DialogController.getPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lesson['title']!,
              style: TextStyle(
                fontSize: DialogController.getFontSize(context, true),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // IMAGE
            Container(
              height: DialogController.getImageHeight(context),
              width: DialogController.getImageWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              lesson['content']!,
              style: TextStyle(
                fontSize: DialogController.getFontSize(context, false),
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),

            // BUTTONS
            SizedBox(
              width: DialogController.getButtonWidth(context),
              child: ElevatedButton(
                onPressed: () {
                  // Close dialog first
                  Navigator.of(context).pop();
                  // Then call onStartLesson to navigate to lesson page
                  if (onStartLesson != null) {
                    onStartLesson();
                  }
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.transparent),
                  backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'START LESSON',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: DialogController.getButtonWidth(context),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.transparent),
                  backgroundColor: Colors.grey,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 20),
                    const Text(
                      'ASSESSMENT',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
