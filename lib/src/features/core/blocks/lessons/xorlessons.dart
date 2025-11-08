import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class Xorlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Xorlessons({super.key, this.onPdfClicked});
  static List<Map<String, String>> lessons = [
    {'pdfPath': 'assets/handouts/xorgate/xorgate.pdf', 'title': 'XOR GATE 1'},
    {'pdfPath': 'assets/handouts/xorgate/xorgate2.pdf', 'title': 'XOR GATE 2'},
  ];

  @override
  State<Xorlessons> createState() => _XorlessonsState();
}

class _XorlessonsState extends State<Xorlessons> {
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
        title: Text('XOR GATE LESSONS'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
          ),
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
                    itemCount: Xorlessons.lessons.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Responsive.getPadding(context) / 2),
                    itemBuilder: (context, index) {
                      final lesson = Xorlessons.lessons[index];
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
