import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/exercises/quizzes/closedialog/closedialog.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/uiassessment/exerciseholder.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => _Exercises();
}

class _Exercises extends State<Exercises> {
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
          ExerciseUI(
            title: "Exercise 1",
            diagram: """
  1 ----\\
         )---- AND ----> ?
  1 ----/
""",
            problem: "What is the output of this AND gate?",
            choices: ["0", "1", "Undefined", "No Output"],
          ),
        ],
      ),
    );
  }
}
