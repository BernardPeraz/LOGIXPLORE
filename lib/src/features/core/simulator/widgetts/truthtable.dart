import 'package:flutter/material.dart';

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

  Flexible AColumn() {
    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [cell("A")]),
            ...widget.Aswitch.map((value) {
              return TableRow(children: [cell(value.toString())]);
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
            ...widget.Bswitch.map((value) {
              return TableRow(children: [cell(value.toString())]);
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
            ...widget.Cswitch.map((value) {
              return TableRow(children: [cell(value.toString())]);
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
            ...widget.Dswitch.map((value) {
              return TableRow(children: [cell(value.toString())]);
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
            ...widget.Eswitch.map((value) {
              return TableRow(children: [cell(value.toString())]);
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
              return TableRow(children: [cell(value.toString())]);
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
      children: [Padding(padding: const EdgeInsets.all(8), child: Text(text))],
    );
  }

  Widget cell(String text) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
