import 'package:flutter/material.dart';

class ResponsiveRectangles extends StatefulWidget {
  const ResponsiveRectangles({super.key});

  @override
  State<ResponsiveRectangles> createState() => _ResponsiveRectanglesState();
}

class _ResponsiveRectanglesState extends State<ResponsiveRectangles> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final rectWidth = width * 0.7; // 70% of screen width
    final rectHeight = height * 0.15; // 15% of screen height

    // Sample logic gate names
    final logicGates = [
      "AND Gate",
      "OR Gate",
      "NOT Gate",
      "NAND Gate",
      "NOR Gate",
      "XOR Gate",
      "XNOR Gate",
      "BUFFER Gate",
    ];

    // Sample progress values (0.0 to 1.0)
    final progressValues = [0.9, 0.6, 0.8, 0.4, 0.7, 0.5, 0.3, 1.0];

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80), // Space above boxes
            ...List.generate(logicGates.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: rectWidth,
                  height: rectHeight,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 94, 255),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logic gate name
                        Text(
                          logicGates[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progressValues[index],
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.lightGreenAccent,
                            ),
                            minHeight: 10,
                          ),
                        ),
                      ],
                    ),
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
