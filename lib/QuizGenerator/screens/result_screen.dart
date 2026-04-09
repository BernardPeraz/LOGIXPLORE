import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/models/question.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/achievementui/badge.dart';

import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final List<String> selectedAnswers; // pinili ng user
  final List<Question> questions;
  final String? selectedAnswer;
  final String gate;

  const ResultScreen({
    super.key,
    required this.score,
    required this.gate,
    required this.selectedAnswers,
    required this.questions,
    required this.selectedAnswer,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool showPerfectUi = false;
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    _saveResult();
    _handleResult();
  }

  Future<void> _handleResult() async {
    await _saveResult();

    if (widget.score == widget.questions.length) {
      Future.delayed(const Duration(milliseconds: 800), () {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          builder: (_) => const PerfectUi(),
        );
      });
    }
  }

  Future<void> _saveResult() async {
    if (isSaved) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    int total = widget.questions.length;
    double progress = widget.score / total;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quiz_scores')
        .add({
          'gate': widget.gate,
          'score': widget.score,
          'total': total,
          'percentage': progress,
          'timestamp': FieldValue.serverTimestamp(),
        });

    setState(() {
      isSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
          image: DecorationImage(
            image: AssetImage("assets/images/background_images/Frame 1.png"),
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),

            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(36),
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Your Score",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      "${widget.score} / ${widget.questions.length}",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 35),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(gate: widget.gate),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 128, 0),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 39,
                          vertical: 15,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("Restart Quiz"),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 128, 0),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Dashboard()),
                        );
                      },
                      child: const Text("Gate Selection"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
