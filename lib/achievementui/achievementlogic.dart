import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/achievementui/achievementdialog.dart';

Future<void> showAchievementDialogForGate({
  required BuildContext context,
  required String quizGateName,
  required String lessonDocName,
}) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final quizRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quiz_scores');

    final latestSnapshot = await quizRef
        .where('gate', isEqualTo: quizGateName)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    final bestSnapshot = await quizRef
        .where('gate', isEqualTo: quizGateName)
        .orderBy('score', descending: true)
        .limit(1)
        .get();

    final lessonSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('lessons_progress')
        .doc(lessonDocName)
        .get();

    int currentScore = 0;
    int totalQuestions = 0;
    int bestScore = 0;

    List<Map<String, String>> badges = [];

    if (latestSnapshot.docs.isNotEmpty) {
      final data = latestSnapshot.docs.first.data();
      currentScore = data['score'];
      totalQuestions = data['total'];
    }

    if (bestSnapshot.docs.isNotEmpty) {
      bestScore = bestSnapshot.docs.first['score'];
    }

    if (bestScore == totalQuestions && totalQuestions > 0) {
      badges.add({
        'image': 'assets/images/background_images/perfectscore.png',
        'title': 'Perfect Score',
      });
    }

    if (lessonSnapshot.exists) {
      List progress = lessonSnapshot['progress'];

      bool completed = progress.every((item) => item == 1);

      if (completed) {
        badges.add({
          'image': 'assets/images/background_images/robotn.png',
          'title': 'Module Complete',
        });
      }
    }

    showDialog(
      context: context,
      builder: (_) => AchievementDialog(
        currentScore: currentScore,
        totalQuestions: totalQuestions,
        bestScore: bestScore,
        earnedBadges: badges,
      ),
    );
  } catch (e) {
    print('Error fetching achievement data: $e');
  }
}
