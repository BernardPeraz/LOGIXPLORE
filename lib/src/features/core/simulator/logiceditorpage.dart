/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/nodewidget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/painters/wirepainter.dart';

import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/truthtable.dart';

class LogicEditorPage extends StatefulWidget {
  final List<int> expectedanswer;
  final String CorrectChat;
  final String WrongChat;

  const LogicEditorPage({
    super.key,
    required this.expectedanswer,
    required this.CorrectChat,
    required this.WrongChat,
  });

  @override
  State<LogicEditorPage> createState() => _LogicEditorPageState();
}

class _LogicEditorPageState extends State<LogicEditorPage> {
  final EditorModel model = EditorModel();
  final GlobalKey canvasKey = GlobalKey();

  final s1 = Node(
    id: 's1',
    kind: 'SWITCH',
    label: 'A',
    position: const Offset(40, 40),
    ports: {
      'out': Port(
        id: 'out',
        type: PortType.output,
        value: false,
        localOffset: const Offset(80, 23),
      ),
    },
    truthvalue: [0, 0, 0, 0, 1, 1, 1, 1],
  );

  final s2 = Node(
    id: 's2',
    kind: 'SWITCH',
    label: 'B',
    position: const Offset(40, 160),
    ports: {
      'out': Port(
        id: 'out',
        type: PortType.output,
        value: false,
        localOffset: const Offset(80, 23),
      ),
    },
    truthvalue: [0, 0, 1, 1, 0, 0, 1, 1],
  );

  final s3 = Node(
    id: 's3',
    kind: 'SWITCH',
    label: 'C',
    position: const Offset(40, 280),
    ports: {
      'out': Port(
        id: 'out',
        type: PortType.output,
        value: false,
        localOffset: const Offset(80, 23),
      ),
    },
    truthvalue: [0, 1, 0, 1, 0, 1, 0, 1],
  );

  final not1 = Node(
    id: 'g2',
    kind: 'RES',
    label: 'result',
    position: const Offset(540, 90),
    ports: {
      'in': Port(
        id: 'in',
        type: PortType.input,
        value: false,
        localOffset: const Offset(0, 20),
      ),
      'out': Port(
        id: 'out',
        type: PortType.output,
        value: false,
        localOffset: const Offset(120, 20),
      ),
    },
  );

  @override
  void initState() {
    super.initState();
    _seedExample();
    model.addListener(() => setState(() {}));
  }

  void _seedExample() {
    model.addNode(s1);
    model.addNode(s2);
    model.addNode(s3);
    model.addNode(not1);
  }

  Offset _globalToLocal(Offset global) {
    final box = canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return global;
    return box.globalToLocal(global);
  }

  PortRef? _hitTestPort(Offset global) {
    final local = _globalToLocal(global);
    for (final node in model.nodes.values) {
      final nodeTopLeft = node.position;
      for (final p in node.ports.values) {
        final portCenter = nodeTopLeft + p.localOffset + const Offset(12, 12);
        final dist = (portCenter - local).distance;
        if (dist <= 25) {
          return PortRef(node.id, p.id, p.type);
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logic Gate Simulator')),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Truth Table
                  Container(
                    child: SwitchTable(
                      Aswitch: s1.truthvalue,
                      Bswitch: s2.truthvalue,
                      Cswitch: s3.truthvalue,
                      Output: not1.truthvalue,
                      Expected: widget.expectedanswer,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Robot + Chat
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/image/robotn.png', height: 300),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Text(
                          listEquals(not1.truthvalue, widget.expectedanswer)
                              ? widget.CorrectChat
                              : widget.WrongChat,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Canvas and interaction area
                  GestureDetector(
                    onPanDown: (d) {
                      final pr = _hitTestPort(d.globalPosition);
                      if (pr != null && pr.type == PortType.output) {
                        model.startConnection(
                          pr,
                          _globalToLocal(d.globalPosition),
                        );
                      }
                    },
                    onPanUpdate: (d) {
                      if (model.connectingFrom != null) {
                        model.updateConnectionDrag(
                          _globalToLocal(d.globalPosition),
                        );
                      }
                    },
                    onPanEnd: (d) {
                      if (model.connectingFrom != null) {
                        model.cancelConnection();
                      }
                    },
                    onTapUp: (d) {
                      final pr = _hitTestPort(d.globalPosition);
                      if (pr != null) {
                        final node = model.nodes[pr.nodeId];
                        if (node?.kind == 'SWITCH') {
                          model.toggleSwitch(node!.id);
                        }
                      }
                    },
                    child: Container(
                      key: canvasKey,
                      color: Colors.grey.shade100,
                      child: CustomPaint(
                        painter: WirePainter(model: model),
                        size: Size.infinite,
                        child: Stack(
                          children: [
                            for (final node in model.nodes.values)
                              Positioned(
                                left: node.position.dx,
                                top: node.position.dy,
                                child: GestureDetector(
                                  onPanUpdate: (d) {
                                    setState(() {
                                      node.position += d.delta;
                                    });
                                    model.notifyListeners();
                                  },
                                  child: NodeWidget(node: node, model: model),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
