import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/achievementui/achievementdialog.dart';

Future<void> showAchievementDialogForGate({
  required BuildContext context,
  required String quizGateName,
  required String lessonDocName,
  required String simuGateName,
}) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    final quizRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quiz_scores');

    final results = await Future.wait([
      quizRef
          .where('gate', isEqualTo: quizGateName)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get(),

      quizRef
          .where('gate', isEqualTo: quizGateName)
          .orderBy('score', descending: true)
          .limit(1)
          .get(),

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('lessons_progress')
          .doc(lessonDocName)
          .get(),

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('simulator_progress')
          .doc(simuGateName)
          .get(),
    ]);

    final QuerySnapshot latestSnapshot = results[0] as QuerySnapshot;
    final QuerySnapshot bestSnapshot = results[1] as QuerySnapshot;
    final DocumentSnapshot lessonSnapshot = results[2] as DocumentSnapshot;
    final DocumentSnapshot simSnapshot = results[3] as DocumentSnapshot;

    int currentScore = 0;
    int totalQuestions = 0;
    int bestScore = 0;

    List<Map<String, String>> badges = [];

    List<int> progress = [];

    if (latestSnapshot.docs.isNotEmpty) {
      final data = latestSnapshot.docs.first.data() as Map<String, dynamic>;

      currentScore = data['score'] ?? 0;
      totalQuestions = data['total'] ?? 0;
    }

    if (bestSnapshot.docs.isNotEmpty) {
      bestScore = bestSnapshot.docs.first.get('score') ?? 0;
    }

    if (bestScore == totalQuestions && totalQuestions > 0) {
      badges.add({
        'image': 'assets/images/background_images/perfectscore.png',
        'title': 'Perfect Score',
      });
    }

    if (lessonSnapshot.exists) {
      final data = lessonSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data['progress'] != null) {
        progress = (data['progress'] as List).map((e) => e as int).toList();
      }

      bool completed =
          progress.isNotEmpty && progress.every((item) => item == 1);

      if (completed) {
        badges.add({
          'image': 'assets/images/background_images/Module_completed.png',
          'title': 'Module Completed!',
        });
      }
    }
    if (simSnapshot.exists) {
      badges.add({
        'image': 'assets/images/logicgatecompletion.png',
        'title': 'Logic Gate Solver!',
      });
    }
    if (!context.mounted) return;
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => AchievementDialog(
        currentScore: currentScore,
        totalQuestions: totalQuestions,
        bestScore: bestScore,
        earnedBadges: badges,
        lessonProgress: progress,
      ),
    );
  } catch (e) {
    print('Error fetching achievement data: $e');
  }
}
