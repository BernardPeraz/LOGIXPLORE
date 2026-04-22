import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultScores extends StatelessWidget {
  const ResultScores({super.key});

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
                  "Students Quiz Scores Overview",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                /// 🔥 HEADER (SCROLLABLE)
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
                          width: 120,
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

                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                const SizedBox(height: 10),

                /// 🔥 LIST
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

                            if (!gateProgress.containsKey(gate)) continue;

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

                          /// 🔥 EACH ROW SCROLLABLE
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      fullName,
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
                                    return SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          gateScoreText[gate] ?? "0/0",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
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
                width: 120,
                child: LinearProgressIndicator(minHeight: 6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
