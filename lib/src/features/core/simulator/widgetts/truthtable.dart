import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/Scorecontroller.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/inputcontroller.dart';

class SwitchTable extends StatefulWidget {
  List<int> Aswitch;
  List<int> Bswitch;
  List<int> Cswitch;
  List<int> Dswitch;
  List<int> Eswitch;
  List<int> Output;
  List<int> Expected;
  String Equation;

  int nums;
  SwitchTable({
    super.key,
    required this.Aswitch,
    required this.Bswitch,
    required this.Cswitch,
    required this.Dswitch,
    required this.Eswitch,
    required this.Output,
    required this.Expected,
    required this.nums,
    required this.Equation,
  });

  @override
  State<SwitchTable> createState() => _SwitchTableState();
}

class _SwitchTableState extends State<SwitchTable> {
  final scoreController = Get.find<Scorecontroller>();
  bool isHovered = false;
  bool submitted = false;
  bool get isCorrect {
    if (widget.Output.length != widget.Expected.length) return false;

    for (int i = 0; i < widget.Output.length; i++) {
      if (widget.Output[i] != widget.Expected[i]) {
        return false;
      }
    }

    return true;
  }

  bool get isAnswerCorrect {
    if (answers.length != widget.Expected.length) return false;

    for (int i = 0; i < answers.length; i++) {
      if (answers[i] != widget.Expected[i]) {
        return false;
      }
    }

    return true;
  }

  Widget ExpressAndScore() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Boolean Expression: ${widget.Equation}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  List<int> answers = [];
  void updateSwitches() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    answers = List.filled(widget.Expected.length, -1);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nums == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),
          const SizedBox(height: 10),

          Row(crossAxisAlignment: CrossAxisAlignment.start, children: []),
        ],
      );
    }

    if (widget.nums == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AColumn(), if (isCorrect) AnswerColumn()],
          ),

          if (isCorrect) ...[const SizedBox(height: 20), SubmitButton()],
        ],
      );
    }
    if (widget.nums == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AColumn(), BColumn(), if (isCorrect) AnswerColumn()],
          ),

          if (isCorrect) ...[const SizedBox(height: 20), SubmitButton()],
        ],
      );
    }
    if (widget.nums == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AColumn(),
              BColumn(),
              CColumn(),
              if (isCorrect) AnswerColumn(),
            ],
          ),

          if (isCorrect) ...[const SizedBox(height: 20), SubmitButton()],
        ],
      );
    }
    if (widget.nums == 4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AColumn(),
              BColumn(),
              CColumn(),
              DColumn(),
              if (isCorrect) AnswerColumn(),
            ],
          ),

          if (isCorrect) ...[const SizedBox(height: 20), SubmitButton()],
        ],
      );
    }

    if (widget.nums == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpressAndScore(),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AColumn(),
              BColumn(),
              CColumn(),
              DColumn(),
              EColumn(),
              if (isCorrect) AnswerColumn(),
            ],
          ),

          if (isCorrect) ...[const SizedBox(height: 20), SubmitButton()],
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Boolean Expression: ${widget.Equation}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AColumn(),
            BColumn(),
            CColumn(),
            DColumn(),
            EColumn(),
            AnswerColumn(),
          ],
        ),
      ],
    );
  }

  final controller = Get.put(Inputcontroller());
  Flexible AColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("A")]),
            ...widget.Aswitch.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;

              return TableRow(
                decoration: BoxDecoration(
                  color: index == controller.level.value ? Colors.yellow : null,
                ),
                children: [cell(value.toString())],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible BColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("B")]),
            ...widget.Bswitch.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;

              return TableRow(
                decoration: BoxDecoration(
                  color: index == controller.level.value ? Colors.yellow : null,
                ),
                children: [cell(value.toString())],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible CColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("C")]),
            ...widget.Cswitch.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;

              return TableRow(
                decoration: BoxDecoration(
                  color: index == controller.level.value ? Colors.yellow : null,
                ),
                children: [cell(value.toString())],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible DColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("D")]),
            ...widget.Dswitch.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;

              return TableRow(
                decoration: BoxDecoration(
                  color: index == controller.level.value ? Colors.yellow : null,
                ),
                children: [cell(value.toString())],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible EColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("E")]),
            ...widget.Eswitch.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;

              return TableRow(
                decoration: BoxDecoration(
                  color: index == controller.level.value ? Colors.yellow : null,
                ),
                children: [cell(value.toString())],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible ExpectedColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("Expected Output")]),
            ...widget.Expected.map((value) {
              return TableRow(
                children: [Center(child: cell(value.toString()))],
              );
            }),
          ],
        ),
      ),
    );
  }

  Flexible OutputColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("O")]),

            ...List.generate(widget.Output.length, (i) {
              bool match = widget.Output[i] == widget.Expected[i];
              return coloredRow(widget.Output[i].toString(), match);
            }),
          ],
        ),
      ),
    );
  }

  Flexible AnswerColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("Answer")]),

            ...List.generate(widget.Expected.length, (i) {
              bool correct = answers[i] == widget.Expected[i];

              return TableRow(
                decoration: submitted
                    ? BoxDecoration(
                        color: correct ? Colors.green[200] : Colors.red[200],
                      )
                    : null,
                children: [
                  InkWell(
                    onTap: submitted
                        ? null
                        : () {
                            setState(() {
                              if (answers[i] == -1) {
                                answers[i] = 0;
                              } else {
                                answers[i] = answers[i] == 0 ? 1 : 0;
                              }
                            });
                          },
                    child: SizedBox(
                      height: 24,
                      child: Center(
                        child: Text(
                          answers[i] == -1 ? "" : answers[i].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  TableRow coloredRow(String text, bool match) {
    return TableRow(
      decoration: BoxDecoration(
        color: match ? Colors.green[200] : Colors.red[200],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Center(child: Text(text)),
        ),
      ],
    );
  }

  Widget cell(String text) => Padding(
    padding: const EdgeInsets.all(2),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget SubmitButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: SizedBox(
            width: 270,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: submitted
                  ? null
                  : () {
                      setState(() {
                        submitted = true;
                      });

                      if (isAnswerCorrect) {
                        scoreController.level.value++;

                        if (scoreController.level.value >
                            scoreController.highscore.value) {
                          scoreController.highscore.value =
                              scoreController.level.value;
                        }
                      } else {
                        scoreController.level.value = 0;
                      }
                    },
              child: Center(
                child: const Text("Submit", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
