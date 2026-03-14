import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/models/question.dart';

class QuestionPage extends StatefulWidget {
  final Question question;
  final bool isLast;

  const QuestionPage({super.key, required this.question, required this.isLast});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String? selected;
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            ...widget.question.choices.map((choice) {
              final isCorrect = choice == widget.question.correctAnswer;

              Color? color;
              if (answered) {
                if (choice == selected) {
                  color = isCorrect ? Colors.green : Colors.red;
                }
              }

              return Card(
                color: color,
                child: ListTile(
                  title: Text(choice),
                  onTap: answered
                      ? null
                      : () {
                          setState(() {
                            selected = choice;
                            answered = true;
                          });
                        },
                ),
              );
            }),

            if (answered)
              Text(
                selected == widget.question.correctAnswer
                    ? "✅ Correct!"
                    : "❌ Wrong!",
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
