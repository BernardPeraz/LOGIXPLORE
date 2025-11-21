import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';

class PatternSwitch extends Node {
  final List<bool> pattern;
  int index = 0;

  PatternSwitch({
    required String id,
    required Offset position,
    required this.pattern,
  }) : super(
         id: id,
         kind: 'PATTERN_SWITCH',
         label: 'PatternSwitch',
         position: position,
         ports: {
           'out': Port(
             id: 'out',
             type: PortType.output,
             value: false,
             localOffset: const Offset(80, 20),
           ),
         },
       );

  void next(EditorModel model) {
    final out = ports['out'];
    if (out == null) return;
    out.value = pattern[index];
    index = (index + 1) % pattern.length;
    model.propagateFromPort(PortRef(id, 'out', PortType.output));
  }
}
