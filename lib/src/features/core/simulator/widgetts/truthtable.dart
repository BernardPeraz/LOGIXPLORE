import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/inputcontroller.dart';

class SwitchTable extends StatefulWidget {
  List<int> Aswitch;
  List<int> Bswitch;
  List<int> Cswitch;
  List<int> Dswitch;
  List<int> Eswitch;
  List<int> Output;
  List<int> Expected;
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
  });

  @override
  State<SwitchTable> createState() => _SwitchTableState();
}

class _SwitchTableState extends State<SwitchTable> {
  void updateSwitches() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nums == 0) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [ExpectedColumn()],
      );
    }
    if (widget.nums == 1) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AColumn(), OutputColumn(), ExpectedColumn()],
      );
    }
    if (widget.nums == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AColumn(), BColumn(), OutputColumn(), ExpectedColumn()],
      );
    }
    if (widget.nums == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AColumn(),
          BColumn(),
          CColumn(),
          OutputColumn(),
          ExpectedColumn(),
        ],
      );
    }
    if (widget.nums == 4) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AColumn(),
          BColumn(),
          CColumn(),
          DColumn(),
          OutputColumn(),
          ExpectedColumn(),
        ],
      );
    }

    if (widget.nums == 5) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AColumn(),
          BColumn(),
          CColumn(),
          DColumn(),
          EColumn(),
          OutputColumn(),
          ExpectedColumn(),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AColumn(),
        BColumn(),
        CColumn(),
        DColumn(),
        EColumn(),
        OutputColumn(),
        ExpectedColumn(),
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
}
