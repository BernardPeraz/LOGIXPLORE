import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/models/question.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Final Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your Score", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(
              "$score / 10",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen(gate: gate)),
                );
              },
              child: const Text("Restart Quiz"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // back to gate selection
              },
              child: const Text("Back to Gate Selection"),
            ),
          ],
        ),
      ),
    );
  }
}
