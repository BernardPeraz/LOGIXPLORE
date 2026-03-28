import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/uploadbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/adminconditions.dart';

class Bufferlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Bufferlessons({super.key, this.onPdfClicked});

  static List<Map<String, dynamic>> lessons = [
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/BUFFERGatelessons/buffergatelesson1.pdf',
      'title': 'BUFFER GATE 1',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/BUFFERGatelessons/buffergatelesson2.pdf',
      'title': 'BUFFER GATE 2',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/BUFFERGatelessons/buffergatelesson3.pdf',
      'title': 'BUFFER GATE 3',
      'progress': 0.0,
    },
  ];

  @override
  State<Bufferlessons> createState() => _BufferlessonsState();
}

class _BufferlessonsState extends State<Bufferlessons> {
  bool editMode = false;
  bool isAdmin = false;
  bool isLoadingAdmin = true;
  @override
  void initState() {
    super.initState();
    _loadSavedProgress();
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    isAdmin = await AdminConditions.isAdmin();

    setState(() {
      isLoadingAdmin = false;
    });
  }

  void _loadSavedProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('lessons_progress')
        .doc('BUFFER')
        .get();

    if (doc.exists && doc.data()!.containsKey('progress')) {
      double savedProgress = doc.data()!['progress'] as double;

      setState(() {
        for (var lesson in Bufferlessons.lessons) {
          lesson['progress'] = savedProgress;
        }
      });
    }
  }

  void _openPdf(String pdfPath, int lessonIndex) {
    html.window.open(pdfPath, '_blank');

    setState(() {
      Bufferlessons.lessons[lessonIndex]['progress'] = 1.0;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('lessons_progress')
          .doc('BUFFER')
          .set({'progress': 1.0, 'updatedAt': DateTime.now()});
    }
    // Call the callback to update progress
    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  double _calculateOverallProgress() {
    double total = 0.0;
    for (var lesson in Bufferlessons.lessons) {
      total += (lesson['progress'] as double);
    }
    return total / Bufferlessons.lessons.length;
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
                  const SizedBox(height: 10),

                  // EDIT BUTTON
                  if (isAdmin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          editMode ? Icons.check : Icons.edit,
                          color: Colors.orange,
                        ),
                        tooltip: editMode ? 'Done Editing' : 'Edit Lessons',
                        onPressed: () {
                          setState(() {
                            editMode = !editMode;
                          });
                        },
                      ),
                    ),

                  SizedBox(height: Responsive.getPadding(context)),

                  Column(
                    children: Bufferlessons.lessons.map((lesson) {
                      int index = Bufferlessons.lessons.indexOf(
                        lesson,
                      ); // index finder

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Responsive.getPadding(context) / 2,
                        ),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            LessonButton(
                              pdfPath: lesson['pdfPath'],
                              lessonTitle: lesson['title'],
                              onPressed: () =>
                                  _openPdf(lesson['pdfPath'], index),
                            ),

                            if (editMode)
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Bufferlessons.lessons.removeAt(index);
                                    // TODO: optionally remove from other lesson lists as needed
                                  });
                                },
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 60),

                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: DialogController.getButtonWidth(context),
                      child: TaskButton(
                        progress: _calculateOverallProgress(),
                        title: 'Buffer',
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: DialogController.getButtonWidth(context),
                      //admin lang dapat makakakita nito
                      child: UploadButton(
                        targetLessonList: Bufferlessons.lessons,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
