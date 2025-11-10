import 'package:flutter/material.dart';

class SwitchTable extends StatelessWidget {
  List<int> Aswitch;
  List<int> Bswitch;
  List<int> Cswitch;
  List<int> Output;
  List<int> Expected;
  SwitchTable({
    super.key,
    required this.Aswitch,
    required this.Bswitch,
    required this.Cswitch,
    required this.Output,
    required this.Expected,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        TableRow(
          children: [
            cell("A"),
            cell("B"),
            cell("C"),
            cell("Output"),
            cell("Expected Output"),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[0].toString()),
            cell(Aswitch[0].toString()),
            cell(Aswitch[0].toString()),
            cell(Output[0].toString()),
            cell(Expected[0].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[1].toString()),
            cell(Bswitch[1].toString()),
            cell(Cswitch[1].toString()),
            cell(Output[1].toString()),
            cell(Expected[1].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[2].toString()),
            cell(Bswitch[2].toString()),
            cell(Cswitch[2].toString()),
            cell(Output[2].toString()),
            cell(Expected[2].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[3].toString()),
            cell(Bswitch[3].toString()),
            cell(Cswitch[3].toString()),
            cell(Output[3].toString()),
            cell(Expected[3].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[4].toString()),
            cell(Bswitch[4].toString()),
            cell(Cswitch[4].toString()),
            cell(Output[4].toString()),
            cell(Expected[4].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[5].toString()),
            cell(Bswitch[5].toString()),
            cell(Cswitch[5].toString()),
            cell(Output[5].toString()),
            cell(Expected[5].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[6].toString()),
            cell(Bswitch[6].toString()),
            cell(Cswitch[6].toString()),
            cell(Output[6].toString()),
            cell(Expected[6].toString()),
          ],
        ),
        TableRow(
          children: [
            cell(Aswitch[7].toString()),
            cell(Bswitch[7].toString()),
            cell(Cswitch[7].toString()),
            cell(Output[7].toString()),
            cell(Expected[7].toString()),
          ],
        ),
      ],
    );
  }

  Widget cell(String text) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
