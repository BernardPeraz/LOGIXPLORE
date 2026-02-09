import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/wire.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/patternswitch.dart';

class EditorModel extends ChangeNotifier {
  Map<String, Node> nodes = {};
  Map<String, Wire> wires = {};

  // temporary connection while dragging
  PortRef? connectingFrom;
  Offset? currentDragPosition;

  void stepAllPatternSwitches() {
    for (final node in nodes.values) {
      if (node is PatternSwitch) {
        node.next(this);
      }
    }
    notifyListeners();
  }

  void addNode(Node node) {
    nodes[node.id] = node;
    notifyListeners();
  }

  void removeNode(String id) {
    nodes.remove(id);
    wires.removeWhere((k, w) => w.from.nodeId == id || w.to.nodeId == id);
    notifyListeners();
  }

  void addWire(Wire w) {
    // optionally check port type validity and duplicates
    // ensure from is output and to is input
    wires[w.id] = w;
    // after wire creation, propagate signal from from.port to newly connected input
    final fromPort = getPortRef(w.from);
    final toPort = getPortRef(w.to);
    if (fromPort != null && toPort != null) {
      toPort.value = fromPort.value;
      propagateFromPort(w.from);
    }
    notifyListeners();
  }

  void removeWire(String id) {
    wires.remove(id);
    notifyListeners();
  }

  Port? getPort(String nodeId, String portId) {
    final node = nodes[nodeId];
    if (node == null) return null;
    return node.ports[portId];
  }

  Port? getPortRef(PortRef ref) => getPort(ref.nodeId, ref.portId);

  void startConnection(PortRef from, Offset globalPos) {
    connectingFrom = from;
    currentDragPosition = globalPos;
    notifyListeners();
  }

  void updateConnectionDrag(Offset globalPos) {
    currentDragPosition = globalPos;
    notifyListeners();
  }

  void cancelConnection() {
    connectingFrom = null;
    currentDragPosition = null;
    notifyListeners();
  }

  void finishConnection(PortRef to) {
    if (connectingFrom == null) {
      cancelConnection();
      return;
    }
    final from = connectingFrom!;
    // basic validation: from must be output, to must be input, not same node
    if (from.type == PortType.output && to.type == PortType.input) {
      final id = 'w${DateTime.now().microsecondsSinceEpoch}';
      addWire(Wire(id: id, from: from, to: to));
    }
    cancelConnection();
  }

  void toggleSwitch(String nodeId) {
    final node = nodes[nodeId];
    if (node == null) return;

    if (node.kind != 'SWITCH') return;
    // switch has an output port with id 'out'
    final out = node.ports['out'];
    if (out == null) return;
    out.value = !out.value;
    propagateFromPort(PortRef(nodeId, out.id, PortType.output));
    notifyListeners();
  }

  void propagateFromPort(PortRef outRef) {
    // BFS queue of output ports whose value changed
    final q = <PortRef>[];
    q.add(outRef);

    while (q.isNotEmpty) {
      final curOut = q.removeAt(0);
      final curVal = getPortRef(curOut)?.value ?? false;

      // find wires starting at this output
      final downstream = wires.values.where(
        (w) => w.from.nodeId == curOut.nodeId && w.from.portId == curOut.portId,
      );

      for (final w in downstream) {
        final target = getPortRef(w.to);
        if (target == null) continue;
        if (target.value != curVal) {
          target.value = curVal;
          // schedule recomputation of the target node (gate)
          final gateNode = nodes[w.to.nodeId];
          if (gateNode != null && gateNode.kind != 'SWITCH') {
            // recompute gate output and if changed, queue its output
            final outputPort = _computeGateOutput(gateNode);
            if (outputPort != null) q.add(outputPort);
          }
        }
      }
    }
    notifyListeners();
  }

  PortRef? _computeGateOutput(Node gate) {
    // Gather input values by input port ordering
    final inputs = gate.ports.values
        .where((p) => p.type == PortType.input)
        .toList();

    final Map<String, bool> inValues = {};
    for (final p in inputs) {
      inValues[p.id] = p.value;
    }

    bool outVal = false;

    switch (gate.kind) {
      case 'AND':
        outVal = inValues.values.fold(true, (a, b) => a && b);
        break;
      case 'OR':
        outVal = inValues.values.fold(false, (a, b) => a || b);
        break;
      case 'NOT':
        outVal = !(inValues.values.isNotEmpty ? inValues.values.first : false);
        break;
      case 'NAND':
        outVal = !(inValues.values.fold(true, (a, b) => a && b));
        break;
      case 'NOR':
        outVal = !(inValues.values.fold(false, (a, b) => a || b));
        break;
      case 'XOR':
        outVal = inValues.values.fold(false, (a, b) => a ^ b);
        break;
      case 'XNOR':
        outVal = !(inValues.values.fold(false, (a, b) => a ^ b));
        break;
      case 'BUFFER':
        outVal = inValues.values.isNotEmpty ? inValues.values.first : false;
        break;
      case 'RES':
        outVal = !(inValues.values.isNotEmpty ? inValues.values.first : false);
        break;
      default:
        outVal = false;
    }

    // Apply to output port
    final outPort = gate.ports.values.firstWhere(
      (p) => p.type == PortType.output,
      orElse: () =>
          Port(id: 'out', type: PortType.output, localOffset: Offset.zero),
    );

    if (outPort.value != outVal) {
      outPort.value = outVal;

      // ======================================================
      // Collect input patterns
      List<List<int>> inputPatterns = [];

      for (final p in inputs) {
        final incomingWire = wires.values.firstWhere(
          (w) => w.to.nodeId == gate.id && w.to.portId == p.id,
          orElse: () => null as Wire,
        );

        final inputNode = nodes[incomingWire.from.nodeId];
        if (inputNode != null) inputPatterns.add(inputNode.truthvalue);
      }

      // Guard: No inputs → output pattern = empty
      if (inputPatterns.isEmpty) {
        gate.truthvalue = [];
      } else {
        int len = inputPatterns[0].length;
        List<int> outPattern = List.filled(len, 0);

        for (int i = 0; i < len; i++) {
          switch (gate.kind) {
            case 'AND':
              outPattern[i] = inputPatterns.every((p) => p[i] == 1) ? 1 : 0;
              break;
            case 'OR':
              outPattern[i] = inputPatterns.any((p) => p[i] == 1) ? 1 : 0;
              break;
            case 'NOT':
              outPattern[i] = inputPatterns[0][i] == 1 ? 0 : 1;
              break;
            case 'NAND':
              outPattern[i] = inputPatterns.every((p) => p[i] == 1) ? 0 : 1;
              break;
            case 'NOR':
              outPattern[i] = inputPatterns.any((p) => p[i] == 1) ? 0 : 1;
              break;
            case 'XOR':
              int sum = inputPatterns.fold(0, (a, b) => a + b[i]);
              outPattern[i] = sum % 2 == 1 ? 1 : 0;
              break;
            case 'XNOR':
              int sum = inputPatterns.fold(0, (a, b) => a + b[i]);
              outPattern[i] = sum % 2 == 0 ? 1 : 0;
              break;
            case 'BUFFER':
              outPattern[i] = inputPatterns[0][i];
              break;
            case 'RES':
              outPattern[i] = inputPatterns[0][i] == 1 ? 1 : 0;
              break;
          }
        }

        gate.truthvalue = outPattern;
      }

      // ======================================================
      return PortRef(gate.id, outPort.id, PortType.output);
    }

    return null;
  }
}
