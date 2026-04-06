import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultScores extends StatelessWidget {
  const ResultScores({super.key});

  // List of gates in correct order
  static const gateList = [
    "AND GATE",
    "OR GATE",
    "NOT GATE",
    "NAND GATE",
    "NOR GATE",
    "XOR GATE",
    "XNOR GATE",
    "BUFFER GATE",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 122, 183, 236), // Light Blue Background
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
                  "Students Quiz Scores Overview",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

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

                const Divider(color: Colors.black, thickness: 2),
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
                      if (fullName.isEmpty) {
                        return SizedBox.shrink();
                      }
                      if (data['hidden'] == true) {
                        return SizedBox.shrink(); // 🔥 Hide this user
                      }

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('quiz_scores')
                            .get(),
                        builder: (context, progressSnapshot) {
                          if (!progressSnapshot.hasData) {
                            return _loadingRow(fullName);
                          }

                          final progressDocs = progressSnapshot.data!.docs;
                          Map<String, double> gateProgress = {
                            for (var gate in gateList) gate: 0.0,
                          };
                          // Convert gate to progress
                          Map<String, String> gateScoreText = {
                            for (var gate in gateList) gate: "0/0",
                          };
                          Map<String, Timestamp?> latestTime = {
                            for (var gate in gateList) gate: null,
                          };

                          for (var gateDoc in progressDocs) {
                            final data = gateDoc.data() as Map<String, dynamic>;

                            final gateRaw = data['gate'] ?? "";
                            final gate = gateRaw
                                .toString()
                                .trim()
                                .toUpperCase();

                            if (!gateProgress.containsKey(gate)) {
                              print("Unknown gate: $gateRaw");
                              continue;
                            }

                            int score = (data['score'] ?? 0);
                            int total = (data['total'] ?? 1);

                            double percent = score / total;

                            Timestamp? time = data['timestamp'];

                            if (latestTime[gate] == null ||
                                (time != null &&
                                    time.compareTo(latestTime[gate]!) > 0)) {
                              latestTime[gate] = time;
                              gateProgress[gate] = percent;
                              gateScoreText[gate] = "$score/$total";
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
                                  return Expanded(
                                    child: Center(
                                      child: Text(
                                        gateScoreText[gate] ?? "0/0",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
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
