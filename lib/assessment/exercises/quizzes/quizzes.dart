import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:studydesign2zzdatabaseplaylist/assessment/exercises/quizzes/closedialog/closedialog.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/uiassessment/quizholder.dart';

class Quizzes extends StatefulWidget {
  final List<Map<String, dynamic>>? passedQuestions;

  const Quizzes({super.key, this.passedQuestions});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  bool isLoading = true;

  int currentIndex = 0;

  List<Map<String, dynamic>> allQuestions = [];

  @override
  void initState() {
    super.initState();

    /// If WhiteScreen passed questions, use them
    if (widget.passedQuestions != null && widget.passedQuestions!.isNotEmpty) {
      allQuestions = widget.passedQuestions!;
      isLoading = false;
      setState(() {});
      return;
    }

    /// Fallback: load from API (optional)
    loadQuestion();
  }

  Future<void> loadQuestion() async {
    try {
      final url = Uri.parse("http://localhost:3000/api/questions");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": "Generate logic gate questions"}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // expect: list of question maps
        final raw = data["questions"];

        allQuestions = List<Map<String, dynamic>>.from(raw);

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int InNum = 5;
    int tchance = 0;
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

          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                Expanded(
                  child: DynamicQuizUI(
                    selectedIndex: InNum,
                    chance: tchance,

                    question: allQuestions[currentIndex]["question"],
                    choices: List<String>.from(
                      allQuestions[currentIndex]["choices"],
                    ),
                    answer: allQuestions[currentIndex]["answer"],
                  ),
                ),

                if (currentIndex < allQuestions.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          InNum = 5;
                          tchance = 0;
                          currentIndex++;
                        });
                      },
                      child: Text("Next Question"),
                    ),
                  ),

                if (currentIndex == allQuestions.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: go to results
                      },
                      child: Text("Finish Quiz"),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
