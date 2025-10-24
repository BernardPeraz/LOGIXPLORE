// desktop_layout.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';

class DesktopLayout {
  static Widget build(
    BuildContext context,
    Map<String, String> lesson,
    String image,
  ) {
    return Row(
      children: [
        // LEFT CONTAINER - TEXT WITH SCROLLBAR
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
                SizedBox(height: 8),

                Text(
                  lesson['subtitle']!,
                  style: TextStyle(
                    fontSize: DialogController.getFontSize(context, false),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
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
                          height: 1.6,
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
                SizedBox(height: 30),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: DialogController.getButtonWidth(context),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              149,
                              0,
                            ),
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'START LESSON',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: DialogController.getButtonWidth(context),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: const Color.fromARGB(
                              255,
                              185,
                              184,
                              184,
                            ),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'ASSESSMENT',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
