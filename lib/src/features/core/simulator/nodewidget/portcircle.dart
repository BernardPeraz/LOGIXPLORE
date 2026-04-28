import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';

class PortCircle extends StatelessWidget {
  final Port port;
  const PortCircle({super.key, required this.port});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.5,
      height: 9.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        // border: Border.all(color: Colors.black54),
        color: port.value ? Colors.red : Colors.black,
      ),
    );
  }
}
