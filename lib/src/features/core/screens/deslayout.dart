// desktop_layout.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';

class DesktopLayout {
  static Widget build(
    BuildContext context,
    Map<String, String> lesson,
    String image, {
    required double progress,
    required VoidCallback onStartLesson,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: DialogController.getPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson['title']!,
                  style: TextStyle(
                    fontSize: DialogController.getFontSize(context, true),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 25),

                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      child: Text(
                        lesson['content']!,
                        style: TextStyle(
                          fontSize: DialogController.getFontSize(
                            context,
                            false,
                          ),
                          height: 2,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // RIGHT CONTAINER - PICTURE AND VERTICAL BUTTONS
        Expanded(
          flex: 1,
          child: Container(
            padding: DialogController.getPadding(context),

            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;

                return Scrollbar(
                  thumbVisibility: screenWidth <= 355,
                  radius: const Radius.circular(10),
                  thickness: 6,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
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
                        const SizedBox(height: 120),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: DialogController.getButtonWidth(context),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Close dialog first
                                  Navigator.of(context).pop();
                                  // Then call onStartLesson to navigate to lesson page
                                  onStartLesson();
                                },
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey),
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    255,
                                    149,
                                    0,
                                  ),
                                  foregroundColor: const Color.fromARGB(
                                    255,
                                    0,
                                    0,
                                    0,
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'START LESSON',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            TaskButton(progress: progress),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
