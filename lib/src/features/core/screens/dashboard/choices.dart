import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/QuizGenerator/screens/quiz_screen.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/main.dart';

class Assessment extends StatelessWidget {
  final String title;

  const Assessment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png'),
        title: Text(
          "LOGIXPLORE",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 1,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? BackgroundImageLight
                : BackgroundImageDark,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // DITO KO INILAGAY YUNG CONTAINER WITH TWO BUTTONS
          Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              constraints: const BoxConstraints(maxWidth: 375),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 15, 69, 220).withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                // DAGDAG: ITO ANG MAGFA-FIX NG OVERFLOW
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Unang Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => QuizScreen(gate: title));
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            149,
                            0,
                          ),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                'QUIZZES',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                    // Pangalawang Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          List<int> output = [];
                          List<String> gates = [];

                          if (title == "AND GATE") {
                            output = [0, 0, 0, 1, 0, 0, 0, 1];
                            gates = ["AND"];
                          } else if (title == "OR GATE") {
                            output = [0, 1, 1, 1, 1, 1, 1, 1];
                            gates = ["OR"];
                          } else if (title == "NOT GATE") {
                            output = [1, 0, 1, 0, 1, 0, 1, 0];
                            gates = ["NOT"];
                          } else if (title == "NAND GATE") {
                            output = [1, 1, 1, 1, 1, 1, 1, 0];
                            gates = ["NAND"];
                          } else if (title == "NOR GATE") {
                            output = [1, 0, 0, 0, 0, 0, 0, 0];
                            gates = ["NOR"];
                          } else if (title == "XOR GATE") {
                            output = [0, 1, 1, 0, 1, 0, 0, 1];
                            gates = ["XOR"];
                          } else if (title == "XNOR GATE") {
                            output = [1, 0, 0, 1, 0, 1, 1, 0];
                            gates = ["XNOR"];
                          } else if (title == "BUFFER GATE") {
                            output = [0, 0, 0, 0, 1, 1, 1, 1];
                            gates = ["BUFFER"];
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogicEditorPage(
                                ExpecOut: output,
                                allowedGates: gates,
                                nextPage: Dashboard(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),

                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            149,
                            0,
                          ),

                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                'SIMULATOR CHALLENGE',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
