import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';

class Wire {
  final String id;
  final PortRef from; // must be output
  final PortRef to; // must be input
  Wire({required this.id, required this.from, required this.to});
}
