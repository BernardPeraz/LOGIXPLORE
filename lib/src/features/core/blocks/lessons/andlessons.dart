import 'package:flutter/material.dart';

class SimpleTextImagePage extends StatefulWidget {
  const SimpleTextImagePage({super.key});

  @override
  State<SimpleTextImagePage> createState() => _SimpleTextImagePageState();
}

class _SimpleTextImagePageState extends State<SimpleTextImagePage> {
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
                  Image.asset(
                    'assets/logo/avatar.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text('Hello World!', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text(
                    'This is a simple page',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

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

                  // Truth table
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Input 1',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Input 2',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Output',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        _buildTableRow('0', '0', '0'),
                        _buildTableRow('0', '1', '0'),
                        _buildTableRow('1', '0', '0'),
                        _buildTableRow('1', '1', '1'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Copyright text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Return true to indicate completion
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String input1, String input2, String output) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(input1, textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(input2, textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(output, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
