// Lesson Button Component
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';

class LessonButton extends StatelessWidget {
  final String pdfPath;
  final String lessonTitle;
  final bool isCompleted;

  final VoidCallback onPressed;

  const LessonButton({
    super.key,
    required this.pdfPath,
    required this.lessonTitle,
    this.isCompleted = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 1, 86, 255),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.picture_as_pdf,
                size: Responsive.getIconSize(context),
                color: Colors.black,
              ),
            ),
            SizedBox(width: Responsive.getPadding(context) / 2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lessonTitle,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
