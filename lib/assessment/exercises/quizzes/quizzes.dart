import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/exercises/quizzes/closedialog/closedialog.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/uiassessment/quizholder.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png'),
        actions: [
          IconButton(
            onPressed: () {
              showExitDialog(context);
            },
            icon: Icon(Icons.close),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_images/light-bg-image.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          DynamicQuizUI(
            question: "What is the output of 1 XOR 0?",
            choices: ["0", "1", "Undefined", "None of the above"],
          ),
        ],
      ),
    );
  }
}
