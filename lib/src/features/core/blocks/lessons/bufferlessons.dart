import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class Bufferlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Bufferlessons({super.key, this.onPdfClicked});

  static List<Map<String, String>> lessons = [];

  @override
  State<Bufferlessons> createState() => _BufferlessonsState();
}

class _BufferlessonsState extends State<Bufferlessons> {
  void _openPdf(String pdfPath, int lessonIndex) {
    html.window.open(pdfPath, '_blank');

    // Call the callback to update progress
    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/buffer.png', fit: BoxFit.contain),
        title: Text('BUFFER GATE LESSONS'),
        actions: [
          Tooltip(
            message: 'Home',
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.home),
            ),
          ),
          SizedBox(width: 23),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? BackgroundImageLight
                : BackgroundImageDark,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.getPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.getPadding(context)),

                Text(
                  'Available Lessons',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context) + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Select a lesson to open the PDF',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context),
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Responsive.getPadding(context)),

                // Lessons List
                Expanded(
                  child: ListView.separated(
                    itemCount: Bufferlessons.lessons.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Responsive.getPadding(context) / 2),
                    itemBuilder: (context, index) {
                      final lesson = Bufferlessons.lessons[index];
                      return LessonButton(
                        pdfPath: lesson['pdfPath']!,
                        lessonTitle: lesson['title']!,

                        onPressed: () => _openPdf(lesson['pdfPath']!, index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
