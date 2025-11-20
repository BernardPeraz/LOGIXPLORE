import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:studydesign2zzdatabaseplaylist/assessment/exercises/quizzes/closedialog/closedialog.dart';
import 'package:studydesign2zzdatabaseplaylist/assessment/uiassessment/quizholder.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  String? questionText; // question from API
  List<String> choices = []; // multiple-choice list
  bool isLoading = true; // loading indicator

  @override
  void initState() {
    super.initState();
    fetchQuestionsFromAPI(); // <--- auto load
  }

  // ------------------------------------------
  // FETCH FROM BACKEND
  // ------------------------------------------
  Future<void> fetchQuestionsFromAPI() async {
    final url = Uri.parse("https://your-render-url/api/questions");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": "Generate logic gate questions"}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String raw = data["questions"];
        List<String> questionList = raw.split("\n");

        // Take ONLY the first question
        String q = questionList[0].replaceAll(RegExp(r"^\d+\.\s*"), "");

        setState(() {
          questionText = q;
          choices = ["A", "B", "C", "D"]; // TEMPORARY choices
          isLoading = false;
        });
      } else {
        setState(() {
          questionText = "Error loading questions.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        questionText = "Failed to connect to server.";
        isLoading = false;
      });
    }
  }

  // ------------------------------------------

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

          isLoading
              ? Center(child: CircularProgressIndicator())
              : DynamicQuizUI(
                  question: questionText ?? "No question loaded",
                  choices: choices,
                ),
        ],
      ),
    );
  }
}
