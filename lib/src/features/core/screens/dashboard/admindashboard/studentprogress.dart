import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentProgressPage extends StatelessWidget {
  const StudentProgressPage({super.key});

  // List of gates in correct order
  static const gateList = [
    "AND",
    "OR",
    "NOT",
    "NAND",
    "NOR",
    "XOR",
    "XNOR",
    "BUFFER",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 88, 166, 233), // Light Blue Background
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          final users = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Student Progress Overview",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // TABLE HEADER (Full Name + 8 Gate Columns)
                //
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Full Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    // GATE COLUMNS
                    ...gateList.map(
                      (gate) => Expanded(
                        child: Text(
                          gate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(thickness: 2),
                SizedBox(height: 10),
                // LIST OF USERS
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final data = users[index].data() as Map<String, dynamic>;
                      final userId = users[index].id;

                      final fullName =
                          "${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}"
                              .trim();
                      if (data['hidden'] == true) {
                        return SizedBox.shrink(); // 🔥 Hide this user
                      }

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('lessons_progress')
                            .get(),
                        builder: (context, progressSnapshot) {
                          if (!progressSnapshot.hasData) {
                            return _loadingRow(fullName);
                          }

                          final progressDocs = progressSnapshot.data!.docs;

                          // Convert gate to progress
                          Map<String, double> gateProgress = {
                            for (var gate in gateList) gate: 0.0,
                          };

                          for (var gateDoc in progressDocs) {
                            final name = gateDoc.id.toUpperCase();
                            final value =
                                (gateDoc.data() as Map<String, dynamic>);
                            if (value.containsKey("progress")) {
                              gateProgress[name] = (value["progress"] as num)
                                  .toDouble();
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                // FULL NAME
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    fullName.isEmpty
                                        ? "Unknown User"
                                        : fullName,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                // 8 INDIVIDUAL GATE PROGRESS BARS
                                ...gateList.map((gate) {
                                  double progress = gateProgress[gate] ?? 0.0;

                                  return Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 45,
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.grey[300],
                                            color: Colors.green,
                                            minHeight: 6,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${(progress * 100).toStringAsFixed(0)}%",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Loading placeholder row (while fetching progress)
  Widget _loadingRow(String fullName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(fullName, style: TextStyle(fontSize: 15)),
          ),
          ...gateList.map(
            (_) => Expanded(
              child: LinearProgressIndicator(
                value: 0,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
