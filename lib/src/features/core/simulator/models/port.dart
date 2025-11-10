import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';

class Port {
  final String id;
  final PortType type;
  bool value;
  Offset localOffset;
  // position relative to node top-left
  Port({
    required this.id,
    required this.type,
    this.value = false,
    required this.localOffset,
  });
}
