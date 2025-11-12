import 'package:flutter/material.dart';

class ExerciseUI extends StatelessWidget {
  final String title; // ex: "Exercise 1"
  final String diagram; // ex: ASCII diagram or explanation
  final String problem; // ex: "What is the output of the following?"
  final List<String> choices; // optional multiple choices

  const ExerciseUI({
    super.key,
    required this.title,
    required this.diagram,
    required this.problem,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Title (Exercise number)
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // ✅ Diagram Area (ASCII or description)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black26),
              ),
              child: Text(
                diagram,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Courier", // para diagram-friendly
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              problem,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            ...choices.map((c) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                    ],
                  ),
                  child: Text(
                    c,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
