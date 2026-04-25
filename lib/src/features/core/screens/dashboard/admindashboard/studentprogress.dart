import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentProgressPage extends StatelessWidget {
  const StudentProgressPage({super.key});

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
      color: Colors.blue,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          final users = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Student Progress Overview",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                /// 🔥 HEADER (HORIZONTAL SCROLL)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          "Full Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),

                      ...gateList.map(
                        (gate) => SizedBox(
                          width: 113,
                          child: Text(
                            gate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(thickness: 2),
                const SizedBox(height: 10),

                // LIST (VERTICAL SCROLL)
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final data = users[index].data() as Map<String, dynamic>;
                      final userId = users[index].id;

                      final fullName =
                          "${data['First Name'] ?? ''} ${data['Last Name'] ?? ''}"
                              .trim();

                      if (fullName.isEmpty || data['hidden'] == true) {
                        return const SizedBox.shrink();
                      }

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('lessons_progress')
                            .snapshots(),
                        builder: (context, progressSnapshot) {
                          if (!progressSnapshot.hasData) {
                            return _loadingRow(fullName);
                          }

                          final progressDocs = progressSnapshot.data!.docs;

                          Map<String, double> gateProgress = {
                            for (var gate in gateList) gate: 0.0,
                          };

                          for (var gateDoc in progressDocs) {
                            final name = gateDoc.id.toUpperCase();
                            final value =
                                gateDoc.data() as Map<String, dynamic>;

                            if (value.containsKey("progress")) {
                              final progressData = value["progress"];

                              if (progressData is List) {
                                int completed = progressData
                                    .where((p) => p == 1.0)
                                    .length;

                                gateProgress[name] = progressData.isNotEmpty
                                    ? completed / progressData.length
                                    : 0.0;
                              } else if (progressData is num) {
                                gateProgress[name] = progressData.toDouble();
                              }
                            }
                          }

                          ///  EACH ROW SCROLLABLE
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      fullName.isEmpty
                                          ? "Unknown User"
                                          : fullName,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),

                                  ...gateList.map((gate) {
                                    double progress = gateProgress[gate] ?? 0.0;

                                    return SizedBox(
                                      width: 120,
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
                                          const SizedBox(width: 4),
                                          Text(
                                            "${(progress * 100).toStringAsFixed(0)}%",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color:
                                                  Theme.of(
                                                        context,
                                                      ).brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
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

  Widget _loadingRow(String fullName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 180, child: Text(fullName)),
            ...gateList.map(
              (_) => const SizedBox(
                width: 100,
                child: LinearProgressIndicator(minHeight: 6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
