import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponsiveRectangles extends StatefulWidget {
  const ResponsiveRectangles({super.key});

  @override
  State<ResponsiveRectangles> createState() => _ResponsiveRectanglesState();
}

class _ResponsiveRectanglesState extends State<ResponsiveRectangles> {
  final logicGates = [
    "AND",
    "OR",
    "NOT",
    "NAND",
    "NOR",
    "XOR",
    "XNOR",
    "BUFFER",
  ];

  Map<String, double> progressMap = {};

  @override
  void initState() {
    super.initState();
    _loadProgressFromFirestore();
  }

  Future<void> _loadProgressFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    for (String gate in logicGates) {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("lessons_progress")
          .doc(gate)
          .get();

      progressMap[gate] = doc.exists
          ? (doc.data()?["progress"] ?? 0.0).toDouble()
          : 0.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        // 📌 BREAKPOINTS
        bool isDesktop = screenWidth >= 1024;
        bool isTablet = screenWidth >= 600 && screenWidth < 1024;
        bool isMobile = screenWidth < 600;

        // 📌 Responsive Rectangle Size
        double rectWidth = isDesktop
            ? screenWidth * 0.60
            : isTablet
            ? screenWidth * 0.80
            : screenWidth * 0.90;

        double rectHeight = isDesktop
            ? 120
            : isTablet
            ? 110
            : 100;

        double titleSize = isDesktop
            ? 22
            : isTablet
            ? 20
            : 18;
        double percentSize = isDesktop
            ? 18
            : isTablet
            ? 16
            : 14;

        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Generate Responsive Blocks
                ...logicGates.map((gate) {
                  double progress = progressMap[gate] ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      width: rectWidth,
                      height: rectHeight,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 1, 94, 255),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$gate Gate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white.withOpacity(0.25),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.lightGreenAccent,
                                ),
                                minHeight: isDesktop ? 12 : 10,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${(progress * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: percentSize,
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
      },
    );
  }
}
