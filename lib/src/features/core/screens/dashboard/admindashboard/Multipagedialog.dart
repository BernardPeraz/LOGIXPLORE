import 'package:flutter/material.dart';

class MultiPageDialog extends StatefulWidget {
  final double width;
  final double height;

  const MultiPageDialog({required this.width, required this.height});

  @override
  State<MultiPageDialog> createState() => _MultiPageDialogState();
}

class _MultiPageDialogState extends State<MultiPageDialog> {
  int pageIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "What is Logixplore?",
      "image": null,
      "text":
          "Logixplore is a web-based learning platform designed to teach students about logic gates. It provides interactive lessons, AI-generated questions, and visual simulations to help students better understand digital logic. The platform guides learners through each logic gate, showing how inputs and outputs work through diagrams, examples, and animations. Students can practice with interactive quizzes that adjust to their performance, giving them personalized learning support. Logixplore also includes simulations that let users experiment with gate combinations and see results in real time. Its goal is to make digital logic learning more intuitive, accessible, and enjoyable for beginners and advanced learners alike.",
    },

    {
      "title": "What are Logic Gates?",
      "image": null,
      "text":
          "Logic gates are basic building blocks used in digital circuits. They take one or more binary inputs and produce a single output based on logical operations. Each gate performs a specific function, such as checking if all inputs are true, verifying if at least one input is true, or inverting a value. These operations are essential for processing information inside computers, calculators, smartphones, and many other electronic devices.",
    },
    {
      "title": "AND Gate",
      "image": "assets/logo/and.png",
      "text":
          "The AND gate outputs 1 only if BOTH inputs are 1. Otherwise, it outputs 0.",
    },
    {
      "title": "OR Gate",
      "image": "assets/logo/or.png",
      "text": "The OR gate outputs 1 if AT LEAST one input is 1.",
    },
    {
      "title": "NOT Gate",
      "image": "assets/logo/not.png",
      "text":
          "The NOT gate inverts its input: if input is 1, output is 0 — and vice versa.",
    },
    {
      "title": "XOR Gate",
      "image": "assets/logo/xor.png",
      "text": "The XOR gate outputs 1 only when inputs are DIFFERENT.",
    },
    {
      "title": "NAND Gate",
      "image": "assets/logo/nand.png",
      "text":
          "The NAND gate outputs 0 only if BOTH inputs are 1. Otherwise, it outputs 1.",
    },
    {
      "title": "NOR Gate",
      "image": "assets/logo/nor.png",
      "text": "The NOR gate outputs 1 only if BOTH inputs are 0.",
    },
    {
      "title": "XNOR Gate",
      "image": "assets/logo/xnor.png",
      "text": "The XNOR gate outputs 1 only if inputs are the SAME.",
    },
    {
      "title": "BUFFER Gate",
      "image": "assets/logo/buffer.png",
      "text":
          "A Buffer outputs exactly the same value as its input. It is used to strengthen signals.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var page = pages[pageIndex];

    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            SizedBox(height: 20),
            // Title
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                page["title"],
                style: const TextStyle(
                  fontSize: 26,

                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // IMAGE (if exists)
            if (page["image"] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  page["image"],
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

            // DESCRIPTION
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  page["text"],
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BACK
                TextButton(
                  onPressed: pageIndex == 0
                      ? null
                      : () {
                          setState(() => pageIndex--);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Back", style: TextStyle(fontSize: 18)),
                  ),
                ),

                // CLOSE
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close", style: TextStyle(fontSize: 18)),
                ),

                // NEXT
                TextButton(
                  onPressed: pageIndex == pages.length - 1
                      ? null
                      : () {
                          setState(() => pageIndex++);
                        },
                  child: const Text("Next", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
