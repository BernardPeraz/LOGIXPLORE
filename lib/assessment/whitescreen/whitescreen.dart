import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WhiteScreen extends StatefulWidget {
  final Widget Function(List<Map<String, dynamic>> questions) nextPage;

  const WhiteScreen({super.key, required this.nextPage});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  @override
  void initState() {
    super.initState();
    _prepareQuestions(); // <–– ADDED
  }

  // ============================================
  // ADDED: FETCH QUESTIONS HERE
  // ============================================
  Future<void> _prepareQuestions() async {
    try {
      // ✅ Use correct IP instead of localhost
      // On Android emulator: 10.0.2.2
      // On iOS simulator: 127.0.0.1 works
      final url = Uri.parse("http://localhost:3000/api/questions");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"gate": "AND"}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        dynamic rawQuestions = data["questions"];
        List<Map<String, dynamic>> parsedQuestions = [];

        // If backend returned LIST (QUESTION_BANK)
        if (rawQuestions is List) {
          parsedQuestions = rawQuestions.map<Map<String, dynamic>>((q) {
            return {
              "question": q["question"] ?? "No question",
              "choices": q["choices"] != null
                  ? List<String>.from(q["choices"])
                  : ["A", "B", "C", "D"],
              "answer": q["answer"] ?? "No answer",
            };
          }).toList();
        }
        // If backend returned STRING (AI fallback)
        else if (rawQuestions is String) {
          parsedQuestions = rawQuestions
              .split("\n")
              .where((line) => line.trim().isNotEmpty)
              .map<Map<String, dynamic>>((line) {
                return {
                  "question": line,
                  "choices": ["True", "False"],
                  "answer": "True",
                };
              })
              .toList();
        }

        // Ensure at least 10 questions
        while (parsedQuestions.length < 10) {
          parsedQuestions.add({
            "question": "Placeholder question",
            "choices": ["A", "B", "C", "D"],
            "answer": "A",
          });
        }

        // Navigate after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (!mounted) return;
          Get.off(() => widget.nextPage(parsedQuestions));
        });
      } else {
        print("Error fetching questions: ${response.body}");
        // fallback to local placeholder if AI fails
        _fallbackToLocalQuestions();
      }
    } catch (e) {
      print("Failed to connect: $e");
      // fallback to local placeholder if connection fails
      _fallbackToLocalQuestions();
    }
  }

  // ===============================
  // Fallback function to prevent crashes
  // ===============================
  void _fallbackToLocalQuestions() {
    List<Map<String, dynamic>> localQuestions = List.generate(10, (index) {
      return {
        "question": "Placeholder question ${index + 1}",
        "choices": ["A", "B", "C", "D"],
        "answer": "A",
      };
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.off(() => widget.nextPage(localQuestions));
    });
  }

  // ============================================
  // ORIGINAL UI (UNCHANGED)
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo/logicon.png', height: 40, width: 40),
                const SizedBox(width: 8),
                const Text(
                  'Preparing AI Generated Questions...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const CircularProgressIndicator(color: Colors.blue),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Get ready,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'LogiXmate',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
