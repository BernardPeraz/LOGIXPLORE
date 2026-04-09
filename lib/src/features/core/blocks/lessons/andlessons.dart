import 'package:studydesign2zzdatabaseplaylist/achievementui/achievementdialog.dart';
import 'package:studydesign2zzdatabaseplaylist/achievementui/achievementlogic.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/lessons_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/lessonbutton/lessonbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/taskbutton.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/uploadbutton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/admindashboard/adminconditions.dart';

class Andlessons extends StatefulWidget {
  final Function(String pdfPath)? onPdfClicked;

  const Andlessons({super.key, this.onPdfClicked});

  static List<Map<String, dynamic>> lessons = [];

  @override
  State<Andlessons> createState() => _AndlessonsState();
}

class _AndlessonsState extends State<Andlessons> {
  bool editMode = false; // added for edit/delete toggle
  bool isAdmin = false;
  bool isLoadingAdmin = true;
  //bagong idinagdag ko
  Future<void> _loadLessons() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .where('gateType', isEqualTo: 'AND')
        .get();

    setState(() {
      Andlessons.lessons = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'pdfPath': data['pdfPath'] ?? '',
          'title': data['title'] ?? 'No Title',
          'progress': 0.0,
        };
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLessons();
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
        .doc('AND')
        .get();

    if (doc.exists && doc.data()!.containsKey('progress')) {
      setState(() {
        List progressList = doc.data()!['progress'];

        setState(() {
          for (int i = 0; i < Andlessons.lessons.length; i++) {
            Andlessons.lessons[i]['progress'] = i < progressList.length
                ? progressList[i]
                : 0.0;
          }
        });
      });
    }
  }

  Future<void> _openPdf(String pdfPath, int lessonIndex) async {
    final Uri url = Uri.parse(pdfPath);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }

    setState(() {
      Andlessons.lessons[lessonIndex]['progress'] = 1.0;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<double> progressList = Andlessons.lessons.map((lesson) {
        var value = lesson['progress'];

        if (value is double) return value;
        if (value is int) return value.toDouble();
        return 0.0;
      }).toList();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('lessons_progress')
          .doc('AND')
          .set({'progress': progressList, 'updatedAt': DateTime.now()});
    }
    if (widget.onPdfClicked != null) {
      widget.onPdfClicked!(pdfPath);
    }
  }

  double _calculateOverallProgress() {
    double total = 0.0;
    for (var lesson in Andlessons.lessons) {
      //binago
      total += (lesson['progress'] as num?)?.toDouble() ?? 0.0;
    }
    return total / Andlessons.lessons.length;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/and.png', fit: BoxFit.contain),
        title: Text('AND GATE LESSONS'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showAchievementDialogForGate(
                            context: context,
                            quizGateName: 'AND GATE',
                            lessonDocName: 'AND',
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenWidth * 0.015,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.amber,
                              size: Responsive.getFontSize(context) + 6,
                            ),

                            SizedBox(width: screenWidth * 0.01),

                            Text(
                              'Achievements earned',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: (screenWidth * 0.025).clamp(12, 17),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
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

                  // LESSONS LIST WITH DELETE IN EDIT MODE
                  Column(
                    children: Andlessons.lessons.map((lesson) {
                      int index = Andlessons.lessons.indexOf(lesson);

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
                                //binago
                                onPressed: () async {
                                  final lesson = Andlessons.lessons[index];

                                  String pdfUrl = lesson['pdfPath'];
                                  String filePath = pdfUrl
                                      .split('/pdfsave/')
                                      .last;
                                  final docId = lesson['id'];

                                  // 1. delete sa Firestore
                                  await FirebaseFirestore.instance
                                      .collection('lessons')
                                      .doc(docId)
                                      .delete();
                                  await Supabase.instance.client.storage
                                      .from('pdfsave')
                                      .remove([filePath]);

                                  // 2. remove sa UI
                                  setState(() {
                                    Andlessons.lessons.removeAt(index);
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
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: DialogController.getButtonWidth(context),
                      child: TaskButton(
                        progress: _calculateOverallProgress(),
                        title: 'AND GATE',
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
                        targetLessonList: Andlessons.lessons,
                        gatesType: 'AND',
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
