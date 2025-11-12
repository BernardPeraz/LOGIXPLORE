import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class Xnorlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Xnorlessons({super.key, this.onPdfClicked});

  static List<Map<String, dynamic>> lessons = [
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/XNORGatelessons/xnorgatelesson1.pdf',
      'title': 'XNOR GATE 1',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/XNORGatelessons/xnorgatelesson2..pdf',
      'title': 'XNOR GATE 2',
      'progress': 0.0,
    },
  ];

  @override
  State<Xnorlessons> createState() => _XnorlessonsState();
}

class _XnorlessonsState extends State<Xnorlessons> {
  void _openPdf(String pdfPath, int lessonIndex) {
    html.window.open(pdfPath, '_blank');
    setState(() {
      Xnorlessons.lessons[lessonIndex]['progress'] = 1.0;
    });

    // Call the callback to update progress
    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  double _calculateOverallProgress() {
    double total = 0.0;
    for (var lesson in Xnorlessons.lessons) {
      total += (lesson['progress'] as double);
    }
    return total / Xnorlessons.lessons.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/xnor.png', fit: BoxFit.contain),
        title: Text('XNOR GATE LESSONS'),
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

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Responsive.getPadding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    'Available Lessons',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context) + 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),

                  Text(
                    'Select a lesson to open the PDF',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context),
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: Responsive.getPadding(context)),

                  Column(
                    children: Xnorlessons.lessons.map((lesson) {
                      int index = Xnorlessons.lessons.indexOf(
                        lesson,
                      ); // index finder

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Responsive.getPadding(context) / 2,
                        ),
                        child: LessonButton(
                          pdfPath: lesson['pdfPath'],
                          lessonTitle: lesson['title'],
                          onPressed: () => _openPdf(lesson['pdfPath'], index),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 60),

                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: DialogController.getButtonWidth(context),
                      child: TaskButton(progress: _calculateOverallProgress()),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
