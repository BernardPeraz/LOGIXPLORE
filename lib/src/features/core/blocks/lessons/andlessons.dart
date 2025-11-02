import 'package:flutter/material.dart';

class Andlessons extends StatelessWidget {
  const Andlessons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'AND GATES',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 100),
                  // Your AND gate description text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'The AND gate produces an output of true only when both inputs are true. Otherwise, the output is false. In other words, the output is 1 only when both inputs are 1, and 0 if even one of the inputs is 0. The gate is named so because, if 0 is false and 1 is true, the gate acts in the same way as the logical and operator. Figure 1 provides a truth table showing the circuit symbol and logic combinations for an AND gate. In the symbol, the input terminals are on the left, and the output terminal is on the right.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.bottomRight,

                      child: ElevatedButton(
                        onPressed: () {
                          // Return true to indicate completion
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Copyright text
                  Align(
                    child: Text(
                      '©2025 LOGIXPLORE, ALL RIGHTS RESERVED',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 80), // Extra space for the Done button
                ],
              ),
            ),
          ),

          // Done Button - Bottom Right
          // andlessons.dart - SimpleTextImagePage
          // Done Button - Bottom Right
        ],
      ),
    );
  }
}
