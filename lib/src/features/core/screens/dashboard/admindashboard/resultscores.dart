import 'package:flutter/material.dart';

class ResultScores extends StatelessWidget {
  const ResultScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 88, 166, 233), // Light Blue Background
      child: Center(
        child: Text(
          "Result Scores Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
