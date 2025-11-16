import 'package:flutter/material.dart';

class DynamicQuizUI extends StatelessWidget {
  final String question;
  final List<String> choices;

  const DynamicQuizUI({
    super.key,
    required this.question,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ...choices.map((choice) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: Offset(0, 3),
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                    ],
                  ),
                  child: Text(
                    choice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
