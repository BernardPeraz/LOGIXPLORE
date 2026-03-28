import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/uploadbutton.dart';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/adminconditions.dart';

class Nandlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Nandlessons({super.key, this.onPdfClicked});

  static List<Map<String, dynamic>> lessons = [
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/NANDGatelessons/nandgatelesson1.pdf',
      'title': 'NAND GATE 1',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/NANDGatelessons/nandgatelesson2.pdf',
      'title': 'NAND GATE 2',
      'progress': 0.0,
    },
    {
      'pdfPath':
          'https://yumufbsbqiwnjnzkacnn.supabase.co/storage/v1/object/public/pdfs/NANDGatelessons/nandgatelesson3.pdf',
      'title': 'NAND GATE 3',
      'progress': 0.0,
    },
  ];

  @override
  State<Nandlessons> createState() => _NandlessonsState();
}

class _NandlessonsState extends State<Nandlessons> {
  bool editMode = false; // added for edit/delete toggle
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
        .doc('NAND')
        .get();

    if (doc.exists && doc.data()!.containsKey('progress')) {
      double savedProgress = doc.data()!['progress'] as double;

      setState(() {
        for (var lesson in Nandlessons.lessons) {
          lesson['progress'] = savedProgress;
        }
      });
    }
  }

  void _openPdf(String pdfPath, int lessonIndex) {
    html.window.open(pdfPath, '_blank');

    setState(() {
      Nandlessons.lessons[lessonIndex]['progress'] = 1.0;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('lessons_progress')
          .doc('NAND')
          .set({'progress': 1.0, 'updatedAt': DateTime.now()});
    }

    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  double _calculateOverallProgress() {
    double total = 0.0;
    for (var lesson in Nandlessons.lessons) {
      total += (lesson['progress'] as double);
    }
    return total / Nandlessons.lessons.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/nand.png'),
        title: const Text('NAND GATE LESSONS'),
        actions: [
          Tooltip(
            message: 'Home',
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.home),
            ),
          ),
          const SizedBox(width: 23),
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

                  Column(
                    children: Nandlessons.lessons.map((lesson) {
                      int index = Nandlessons.lessons.indexOf(
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
                                    Nandlessons.lessons.removeAt(index);
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
                        title: 'Nand',
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
                        targetLessonList: Nandlessons.lessons,
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
