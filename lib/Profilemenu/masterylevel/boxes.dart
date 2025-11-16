import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponsiveRectangles extends StatefulWidget {
  const ResponsiveRectangles({super.key});

  @override
  State<ResponsiveRectangles> createState() => _ResponsiveRectanglesState();
}

class _ResponsiveRectanglesState extends State<ResponsiveRectangles> {
  // Logic gate list (same as yours)
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

  Map<String, double> progressMap = {}; // store gate → progress

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

      if (doc.exists) {
        progressMap[gate] = (doc.data()?["progress"] ?? 0.0).toDouble();
      } else {
        progressMap[gate] = 0.0;
      }
    }

    setState(() {}); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final rectWidth = width * 0.7;
    final rectHeight = height * 0.15;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),

            // Generate the rectangles
            ...logicGates.map((gate) {
              final progress = progressMap[gate] ?? 0.0; // default 0 if loading

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: rectWidth,
                  height: rectHeight,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 94, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$gate Gate",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.lightGreenAccent,
                            ),
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${(progress * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
