import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';

class Node {
  final String id;
  String kind; // "AND", "OR", "NOT", "SWITCH"
  String label;
  Offset position;
  Map<String, Port> ports;
  bool collapsed = false;
  List<int> truthvalue = [];
  Node({
    required this.id,
    required this.kind,
    required this.label,
    required this.position,
    required this.ports,
    List<int>? truthvalue,
  }) : truthvalue = truthvalue ?? [0, 0, 0, 0, 0, 0, 0, 0];
}
