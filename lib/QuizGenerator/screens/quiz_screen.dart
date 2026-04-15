import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/logix_api.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String gate;

  const QuizScreen({super.key, required this.gate});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? selectedAnswer;
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = true;
  bool answered = false;

  final letters = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    final data = await LogixApi.fetchQuiz(widget.gate);
    setState(() {
      questions = data;
      isLoading = false;
      currentIndex = 0;
      score = 0;
    });
  }

  void selectAnswer(String letter) {
    if (answered) return;

    final correct = questions[currentIndex].correctAnswer.trim().toUpperCase();
    final selected = letter.trim().toUpperCase();

    setState(() {
      answered = true;
      selectedAnswer = selected;
      if (selected == correct) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < 9) {
        setState(() {
          currentIndex++;
          answered = false;
          selectedAnswer = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: score,
              gate: widget.gate,
              selectedAnswers: questions
                  .map((q) => q.choices[letters.indexOf(selectedAnswer ?? 'A')])
                  .toList(),
              questions: questions,
              selectedAnswer: selectedAnswer,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.memory, size: 80, color: Colors.white),
              const SizedBox(height: 30),

              Text(
                "Generating ${widget.gate} Quiz",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Please wait while LogiX creates 10 smart questions for you...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 40),

              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      );
    }

    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "${widget.gate} Quiz (${currentIndex + 1}/10)",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 53, 207, 250),
        actions: [
          Tooltip(
            message: 'Close',
            child: IconButton(
              icon: Icon(Icons.close_rounded),
              iconSize: 25,
              onPressed: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: Border.fromBorderSide(BorderSide.none),
                      title: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to close?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true); // confirm
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false); // cancel
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  Navigator.pop(context); // dito lang mag close
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background_images/Rectangle 1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 90),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Text(
                    question.question,

                    style: const TextStyle(
                      color: Colors.black,

                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                ...List.generate(4, (index) {
                  final letter = letters[index];
                  final choice = question.choices[index];

                  Color? color;

                  if (answered) {
                    if (letter == question.correctAnswer) {
                      color = Colors.green;
                    } else if (letter == selectedAnswer) {
                      color = Colors.red; // maling pinili
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        minimumSize: const Size(450, 60),
                        backgroundColor: color ?? Colors.white,
                        side: BorderSide(style: BorderStyle.none),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => selectAnswer(letter),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "$letter. $choice",

                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
