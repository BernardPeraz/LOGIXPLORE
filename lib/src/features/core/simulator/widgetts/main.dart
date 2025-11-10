import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/nodewidget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/painters/wirepainter.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/truthtable.dart';

// ---------- UI ----------

void main() {
  runApp(const LogicSimApp());
}

class LogicSimApp extends StatelessWidget {
  const LogicSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logic Gate Simulator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LogicEditorPage(),
    );
  }
}

class LogicEditorPage extends StatefulWidget {
  const LogicEditorPage({super.key});

  @override
  State<LogicEditorPage> createState() => _LogicEditorPageState();
}

class _LogicEditorPageState extends State<LogicEditorPage> {
  final EditorModel model = EditorModel();
  // For simplicity we use a GlobalKey to convert coordinates
  final GlobalKey canvasKey = GlobalKey();

  final s1 = Node(
    // first default node
    id: 's1',
    kind: 'SWITCH',
    label: 'A',
    position: const Offset(40, 40), // position of node
    ports: {
      'out': Port(
        id: 'out',
        type: PortType.output,
        value: false,
        localOffset: const Offset(80, 23),
        //position of port
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
    // add a switch

    final and1 = Node(
      id: 'g1',
      kind: 'AND',
      label: 'and',
      position: const Offset(300, 90),
      ports: {
        'a': Port(
          id: 'a',
          type: PortType.input,
          value: false,
          localOffset: const Offset(10, 10),
        ),
        'b': Port(
          id: 'b',
          type: PortType.input,
          value: false,
          localOffset: const Offset(10, 40),
        ),
        'out': Port(
          id: 'out',
          type: PortType.output,
          value: false,
          localOffset: const Offset(90, 23),
        ),
      },
    );

    model.addNode(s1);
    model.addNode(s2);
    model.addNode(s3);
    model.addNode(and1);
    model.addNode(not1);
  } //above is just adding node

  Offset _globalToLocal(Offset global) {
    //convert screen to local position drawing area
    final box =
        canvasKey.currentContext?.findRenderObject()
            as RenderBox?; //determing canvas  screen
    if (box == null) return global; // if cant find, fallback
    return box.globalToLocal(global); // set the canvas the starting point
  }

  // find port under global position (simple hit test)
  PortRef? _hitTestPort(Offset global) {
    //under port ? Returns PortRef : Returns Null
    final local = _globalToLocal(global);
    for (final node in model.nodes.values) {
      //loop through all the nodes
      final nodeTopLeft = node.position; //locate all nodes
      for (final p in node.ports.values) {
        //loop through all the port
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
      appBar: AppBar(
        title: const Text('Logic Gate Simulator'),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close_rounded),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // placeholder for save
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving not implemented')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: SwitchTable(
                  Aswitch: s1.truthvalue,
                  Bswitch: s2.truthvalue,
                  Cswitch: s3.truthvalue,
                  Output: not1.truthvalue,
                  Expected: [0, 0, 0, 1, 0, 0, 0, 1],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  GestureDetector(
                    onPanDown: (d) {
                      //mouse click
                      // if starting drag on a port -> start connection
                      final pr = _hitTestPort(d.globalPosition);
                      if (pr != null && pr.type == PortType.output) {
                        // iof click to output port
                        model.startConnection(
                          pr,
                          _globalToLocal(d.globalPosition),
                        );
                      }
                    },
                    onPanUpdate: (d) {
                      //mouse hold
                      if (model.connectingFrom != null) {
                        //not connected yet
                        model.updateConnectionDrag(
                          //update the end point location
                          _globalToLocal(d.globalPosition),
                        );
                      }
                    },
                    onPanEnd: (d) {
                      //mouse lift
                      if (model.connectingFrom != null) {
                        // try to finish connection on release location                 //not connected yet
                        final pr = _hitTestPort(
                          d.velocity.pixelsPerSecond == Offset.zero
                              ? Offset.zero
                              : Offset.zero,
                        );
                        // fallback: use last known drag pos
                        final last = model.currentDragPosition;
                        PortRef? target;
                        if (last != null) {
                          final globalLast =
                              (canvasKey.currentContext?.findRenderObject()
                                      as RenderBox?)
                                  ?.localToGlobal(last) ??
                              Offset.zero;
                          target = _hitTestPort(globalLast);
                        }
                        if (target != null && target.type == PortType.input) {
                          model.finishConnection(target);
                        } else {
                          model.cancelConnection();
                        }
                      }
                    },
                    onTapUp: (d) {
                      // check tap on a port to toggle switch if it's a switch output
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
                            // render nodes
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
                            // optionally draw connecting temporary line
                            if (model.connectingFrom != null &&
                                model.currentDragPosition != null)
                              Positioned.fill(
                                child: IgnorePointer(
                                  child: CustomPaint(
                                    painter: TempLinePainter(model: model),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // bottom toolbar
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Column(
                      children: [
                        FloatingActionButton.extended(
                          heroTag: 'addAnd',
                          onPressed: () {
                            final id =
                                'g${DateTime.now().microsecondsSinceEpoch}';
                            final n = Node(
                              id: id,
                              kind: 'AND',
                              label: 'and',
                              position: const Offset(120, 120),
                              ports: {
                                'a': Port(
                                  id: 'a',
                                  type: PortType.input,
                                  localOffset: const Offset(0, 10),
                                ),
                                'b': Port(
                                  id: 'b',
                                  type: PortType.input,
                                  localOffset: const Offset(0, 40),
                                ),
                                'out': Port(
                                  id: 'out',
                                  type: PortType.output,
                                  localOffset: const Offset(120, 25),
                                ),
                              },
                            );
                            model.addNode(n);
                          },
                          label: const Text('Add AND'),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.extended(
                          heroTag: 'addOr',
                          onPressed: () {
                            final id =
                                'g${DateTime.now().microsecondsSinceEpoch}';
                            final n = Node(
                              id: id,
                              kind: 'OR',
                              label: 'or',
                              position: const Offset(120, 220),
                              ports: {
                                'a': Port(
                                  id: 'a',
                                  type: PortType.input,
                                  localOffset: const Offset(0, 10),
                                ),
                                'b': Port(
                                  id: 'b',
                                  type: PortType.input,
                                  localOffset: const Offset(0, 40),
                                ),
                                'out': Port(
                                  id: 'out',
                                  type: PortType.output,
                                  localOffset: const Offset(120, 25),
                                ),
                              },
                            );
                            model.addNode(n);
                          },
                          label: const Text('Add OR'),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.extended(
                          heroTag: 'addNot',
                          onPressed: () {
                            final id =
                                'g${DateTime.now().microsecondsSinceEpoch}';
                            final n = Node(
                              id: id,
                              kind: 'NOT',
                              label: 'not',
                              position: const Offset(120, 320),
                              ports: {
                                'in': Port(
                                  id: 'in',
                                  type: PortType.input,
                                  localOffset: const Offset(0, 20),
                                ),
                                'out': Port(
                                  id: 'out',
                                  type: PortType.output,
                                  localOffset: const Offset(120, 20),
                                ),
                              },
                            );
                            model.addNode(n);
                          },
                          label: const Text('Add NOT'),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.extended(
                          heroTag: 'addSwitch',
                          onPressed: () {
                            final id =
                                's${DateTime.now().microsecondsSinceEpoch}';
                            final n = Node(
                              id: id,
                              kind: 'SWITCH',
                              label: 'switch',
                              position: const Offset(40, 360),
                              ports: {
                                'out': Port(
                                  id: 'out',
                                  type: PortType.output,
                                  localOffset: const Offset(80, 20),
                                ),
                              },
                            );
                            model.addNode(n);
                          },
                          label: const Text('Add Switch'),
                        ),
                      ],
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
