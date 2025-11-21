import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Orlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Orlessons({super.key, this.onPdfClicked});
  static List<Map<String, dynamic>> lessons = [
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/ORGatelessons/orgatelesson1.pdf',
      'title': 'OR GATE 1',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/ORGatelessons/orgatelesson2.pdf',
      'title': 'OR GATE 2',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/ORGatelessons/orgatelesson2.pdf',
      'title': 'OR GATE 3',
      'progress': 0.0,
    },
  ];

  @override
  State<Orlessons> createState() => _OrlessonsState();
}

class _OrlessonsState extends State<Orlessons> {
  @override
  void initState() {
    super.initState();
    _loadSavedProgress();
  }

  void _loadSavedProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('lessons_progress')
        .doc('OR')
        .get();

    if (doc.exists && doc.data()!.containsKey('progress')) {
      double savedProgress = doc.data()!['progress'] as double;

      setState(() {
        for (var lesson in Orlessons.lessons) {
          lesson['progress'] = savedProgress;
        }
      });
    }
  }

  void _openPdf(String pdfPath, int lessonIndex) {
    html.window.open(pdfPath, '_blank');

    setState(() {
      Orlessons.lessons[lessonIndex]['progress'] = 1.0;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('lessons_progress')
          .doc('OR')
          .set({'progress': 1.0, 'updatedAt': DateTime.now()});
    }
    // Call the callback to update progress
    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  double _calculateOverallProgress() {
    double total = 0.0;
    for (var lesson in Orlessons.lessons) {
      total += (lesson['progress'] as double);
    }
    return total / Orlessons.lessons.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/or.png', fit: BoxFit.contain),
        title: Text('OR GATE LESSONS'),
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
                    children: Orlessons.lessons.map((lesson) {
                      int index = Orlessons.lessons.indexOf(
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
