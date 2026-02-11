import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/nodewidget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/painters/wirepainter.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/truthtable.dart';
import 'package:flutter/foundation.dart'; // for listEquals

// ---------- UI ----------
/*        
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
      // 👇 ADD YOUR ALLOWED GATES HERE
      home: const LogicEditorPage(
        ExpecOut: [0, 0, 0, 1],
        allowedGates: [
          'AND',
            'OR',
          'NOT',
          'NAND',
          'NOR',
          'XOR',
          'XNOR',
          'BUFFER',
        ],
        nextPage: LogicEditorPage(
          ExpecOut: [1, 1, 0, 0],
          allowedGates: ["NOT"],
          nextPage: LogicEditorPage(
            ExpecOut: [1, 0, 0, 0],
            allowedGates: ["AND", "NOT"],
            nextPage: Scaffold(),
          ),
        ),
      ),
    );
  }
}
*/
class LogicEditorPage extends StatefulWidget {
  // NEW: parameter to control which gates are shown
  final List<int> ExpecOut;
  final List<String> allowedGates;
  final Widget nextPage;

  const LogicEditorPage({
    super.key,
    required this.ExpecOut,
    required this.allowedGates,

    // 'AND',
    // 'OR',
    //  'NOT',
    //  'NAND',
    //  'NOR',
    //  'XOR',
    //  'XNOR',
    // 'BUFFER',
    required this.nextPage,
  });

  @override
  State<LogicEditorPage> createState() => _LogicEditorPageState();
}

class _LogicEditorPageState extends State<LogicEditorPage> {
  int switchNum = 0;
  final EditorModel model = EditorModel();
  // For simplicity we use a GlobalKey to convert coordinates
  final GlobalKey canvasKey = GlobalKey();
  List<int> generateTruthValues(int x, String switchNum) {
    return switchNum == "A"
        ? x == 1
              ? [0, 1]
              : x == 2
              ? [0, 0, 1, 1]
              : x == 3
              ? [0, 0, 0, 0, 1, 1, 1, 1]
              : x == 4
              ? [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1]
              : x == 5
              ? [
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                ]
              : []
        : switchNum == "B"
        ? x == 1
              ? [0, 0]
              : x == 2
              ? [0, 1, 0, 1]
              : x == 3
              ? [0, 0, 1, 1, 0, 0, 1, 1]
              : x == 4
              ? [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1]
              : x == 5
              ? [
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                  1,
                ]
              : []
        : switchNum == "C"
        ? x == 1
              ? [0, 0]
              : x == 2
              ? [0, 0, 0, 0]
              : x == 3
              ? [0, 1, 0, 1, 0, 1, 0, 1]
              : x == 4
              ? [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1]
              : x == 5
              ? [
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  1,
                  1,
                  1,
                ]
              : []
        : switchNum == "D"
        ? x == 1
              ? [0, 0]
              : x == 2
              ? [0, 0, 0, 0]
              : x == 3
              ? [0, 0, 0, 0, 0, 0, 0, 0]
              : x == 4
              ? [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]
              : x == 5
              ? [
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                  0,
                  0,
                  1,
                  1,
                ]
              : []
        : switchNum == "E"
        ? x == 1
              ? [0, 0]
              : x == 2
              ? [0, 0, 0, 0]
              : x == 3
              ? [0, 0, 0, 0, 0, 0, 0, 0]
              : x == 4
              ? [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
              : x == 5
              ? [
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                  0,
                  1,
                ]
              : []
        : [];
  }

  late Node s1;
  late Node s2;
  late Node s3;
  late Node s4;
  late Node s5;
  late Node not1;

  @override
  void initState() {
    super.initState();

    s1 = Node(
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

      truthvalue: generateTruthValues(switchNum, "A"),
    );
    s2 = Node(
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
      truthvalue: generateTruthValues(switchNum, "B"),
    );
    s3 = Node(
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
      truthvalue: generateTruthValues(switchNum, "C"),
    );
    s4 = Node(
      id: 's4',
      kind: 'SWITCH',
      label: 'D',
      position: const Offset(40, 400),
      ports: {
        'out': Port(
          id: 'out',
          type: PortType.output,
          value: false,
          localOffset: const Offset(80, 23),
        ),
      },
      truthvalue: generateTruthValues(switchNum, "D"),
    );
    s5 = Node(
      id: 's5',
      kind: 'SWITCH',
      label: 'E',
      position: const Offset(40, 520),
      ports: {
        'out': Port(
          id: 'out',
          type: PortType.output,
          value: false,
          localOffset: const Offset(80, 23),
        ),
      },
      truthvalue: generateTruthValues(switchNum, "E"),
    );

    not1 = Node(
      id: 'output',
      kind: 'RES',
      label: 'output',
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
    _seedExample();
    model.addListener(() => setState(() {}));
  }

  void _seedExample() {
    // add a switch

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

  // Helper to check if a gate is allowed
  bool gateAllowed(String type) {
    return widget.allowedGates.contains(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logic Gate Simulator'),
        actions: [
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
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Container(
                        child: SwitchTable(
                          Aswitch: s1.truthvalue,
                          Bswitch: s2.truthvalue,
                          Cswitch: s3.truthvalue,
                          Dswitch: s4.truthvalue,
                          Eswitch: s5.truthvalue,
                          Output: not1.truthvalue,
                          Expected: widget.ExpecOut,
                          nums: switchNum,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,

                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/robotn.png', height: 250),
                        Positioned(
                          top: 28,

                          child: Container(
                            width: 310,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Text(
                              (s1.truthvalue.length == widget.ExpecOut.length)
                                  ? listEquals(not1.truthvalue, widget.ExpecOut)
                                        ? 'Good job! The output is correct means you chose gates correctly.'
                                        : 'Good! the ouput length is correct, now use correct gates to do the expected output'
                                  : (2 ^ (switchNum + 1) <
                                        widget.ExpecOut.length)
                                  ? "Let’s use the switches to get ${widget.ExpecOut} as Expected Output "
                                  : 'Output length is more than expected output length, please restart',

                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        listEquals(not1.truthvalue, widget.ExpecOut)
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => widget.nextPage,
                                    ),
                                  );
                                },
                                child: Text("Proceed to Next Level"),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  GestureDetector(
                    onPanDown: (d) {
                      setState(() {});
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
                      setState(() {});
                      model.toggleSwitch("1");
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
                      setState(() {
                        model.toggleSwitch("1");
                      });
                      model.toggleSwitch("1");
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
                        model.toggleSwitch(node!.id);
                        model.toggleSwitch("1");
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
                                      model.propagateFromPort(
                                        PortRef('s1', 'out', PortType.output),
                                      );
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

                  // --------------------------------------------------
                  // ------------------- TOOLBAR ----------------------
                  // --------------------------------------------------
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Column(
                      children: [
                        FloatingActionButton.extended(
                          heroTag: '✅',
                          onPressed: () {
                            setState(() {
                              switchNum = 0;
                              model.nodes.clear();
                              model.addNode(not1);
                            });
                          },
                          label: const Text('RESET'),
                        ),
                        FloatingActionButton.extended(
                          heroTag: '✅',
                          onPressed: () {
                            if (not1.truthvalue == widget.ExpecOut) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Title here"),
                                    content: Text(
                                      "This is the message inside the dialog.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          ); // close dialog
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            setState(() {
                              model.toggleSwitch("s1");
                              model.toggleSwitch("s2");
                              model.toggleSwitch("s3");
                              model.toggleSwitch("s4");
                              model.toggleSwitch("s5");
                              model.toggleSwitch("s1");
                              model.toggleSwitch("s2");
                              model.toggleSwitch("s3");
                              model.toggleSwitch("s4");
                              model.toggleSwitch("s5");
                              model.toggleSwitch("s1");
                              model.toggleSwitch("s2");
                              model.toggleSwitch("s3");
                              model.toggleSwitch("s4");
                              model.toggleSwitch("s5");
                              model.toggleSwitch("s1");
                              model.toggleSwitch("s2");
                              model.toggleSwitch("s3");
                              model.toggleSwitch("s4");
                              model.toggleSwitch("s5");
                            });
                          },
                          label: const Text('Submit'),
                        ),
                        const SizedBox(height: 10),
                        // ------------------- ADD SWITCH -------------------
                        FloatingActionButton.extended(
                          heroTag: 'addSwitch',
                          onPressed: () {
                            if (switchNum < 5) {
                              switchNum = switchNum + 1;
                              setState(() {
                                if (switchNum == 1) {
                                  model.addNode(s1);
                                } else if (switchNum == 2) {
                                  model.addNode(s2);
                                } else if (switchNum == 3) {
                                  model.addNode(s3);
                                } else if (switchNum == 4) {
                                  model.addNode(s4);
                                } else if (switchNum == 5) {
                                  model.addNode(s5);
                                }
                                setState(() {
                                  s1.truthvalue = generateTruthValues(
                                    switchNum,
                                    "A",
                                  );
                                });
                                setState(() {
                                  s2.truthvalue = generateTruthValues(
                                    switchNum,
                                    "B",
                                  );
                                });
                                setState(() {
                                  s3.truthvalue = generateTruthValues(
                                    switchNum,
                                    "C",
                                  );
                                });
                              });
                              setState(() {
                                s4.truthvalue = generateTruthValues(
                                  switchNum,
                                  "D",
                                );
                              });
                              setState(() {
                                s5.truthvalue = generateTruthValues(
                                  switchNum,
                                  "E",
                                );
                              });
                            } else {
                              () {
                                //what to do after reaching maximum input counts
                              };
                            }
                          },
                          label: const Text('Add Switch'),
                        ),
                        const SizedBox(height: 8),
                        // ------------------- AND -------------------
                        if (gateAllowed('AND'))
                          FloatingActionButton.extended(
                            heroTag: 'addAnd',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'AND',
                                label: 'annd',
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
                                    localOffset: const Offset(90, 25),
                                  ),
                                },
                              );
                              model.addNode(n);
                              setState(() {});
                            },
                            label: Tooltip(
                              message: "AND GATE",
                              child: Image.asset(
                                'assets/images/Annd.png',
                                height: 40,
                              ),
                            ),
                          ),
                        if (gateAllowed('AND')) const SizedBox(height: 8),

                        // ------------------- OR -------------------
                        if (gateAllowed('OR'))
                          FloatingActionButton.extended(
                            heroTag: 'addOr',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'OR',
                                label: 'ooor',
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
                            label: Image.asset(
                              'assets/images/Ooor.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('OR')) const SizedBox(height: 8),

                        // ------------------- NOT -------------------
                        if (gateAllowed('NOT'))
                          FloatingActionButton.extended(
                            heroTag: 'addNot',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'NOT',
                                label: 'noot',
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
                            label: Image.asset(
                              'assets/images/Noot.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('NOT')) const SizedBox(height: 8),

                        // ------------------- NAND -------------------
                        if (gateAllowed('NAND'))
                          FloatingActionButton.extended(
                            heroTag: 'addNand',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'NAND',
                                label: 'naand',
                                position: const Offset(120, 420),
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
                            label: Image.asset(
                              'assets/images/Naand.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('NAND')) const SizedBox(height: 8),

                        // ------------------- NOR -------------------
                        if (gateAllowed('NOR'))
                          FloatingActionButton.extended(
                            heroTag: 'addNor',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'NOR',
                                label: 'noor',
                                position: const Offset(120, 520),
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
                            label: Image.asset(
                              'assets/images/Noor.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('NOR')) const SizedBox(height: 8),

                        // ------------------- XOR -------------------
                        if (gateAllowed('XOR'))
                          FloatingActionButton.extended(
                            heroTag: 'addXor',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'XOR',
                                label: 'xoor',
                                position: const Offset(120, 620),
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
                            label: Image.asset(
                              'assets/images/Xoor.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('XOR')) const SizedBox(height: 8),

                        // ------------------- XNOR -------------------
                        if (gateAllowed('XNOR'))
                          FloatingActionButton.extended(
                            heroTag: 'addXnor',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'XNOR',
                                label: 'xnoor',
                                position: const Offset(120, 620),
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
                            label: Image.asset(
                              'assets/images/Xnoor.png',
                              height: 40,
                            ),
                          ),
                        if (gateAllowed('XNOR')) const SizedBox(height: 8),

                        // ------------------- BUFFER -------------------
                        if (gateAllowed('BUFFER'))
                          FloatingActionButton.extended(
                            heroTag: 'addBuffer',
                            onPressed: () {
                              final id =
                                  'g${DateTime.now().microsecondsSinceEpoch}';
                              final n = Node(
                                id: id,
                                kind: 'BUFFER',
                                label: 'bufffer',
                                position: const Offset(120, 620),
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
                            label: Image.asset(
                              'assets/images/Bufffer.png',
                              height: 40,
                            ),
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
