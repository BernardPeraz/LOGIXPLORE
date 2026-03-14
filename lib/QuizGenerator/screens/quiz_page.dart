import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/models/question.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/screens/questions_page.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/services/logix_api.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String gate;

  const QuizPage({super.key, required this.gate});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    questions = await LogixApi.fetchQuiz(widget.gate);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text("${widget.gate} Gate Quiz")),
      body: PageView.builder(
        itemCount: questions.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return QuestionPage(
            question: questions[index],
            isLast: index == questions.length - 1,
          );
        },
      ),
    );
  }
}
