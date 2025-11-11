import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class Xnorlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Xnorlessons({super.key, this.onPdfClicked});

  static List<Map<String, String>> lessons = [
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/XNORGatelessons/xnorgatelesson1.pdf',
      'title': 'XNOR GATE 1',
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/XNORGatelessons/xnorgatelesson2..pdf',
      'title': 'XNOR GATE 2',
    },
  ];

  @override
  State<Xnorlessons> createState() => _XnorlessonsState();
}

class _XnorlessonsState extends State<Xnorlessons> {
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
                    itemCount: Xnorlessons.lessons.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Responsive.getPadding(context) / 2),
                    itemBuilder: (context, index) {
                      final lesson = Xnorlessons.lessons[index];
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
