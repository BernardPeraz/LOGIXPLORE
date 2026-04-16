import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/achievementui/achievement_manager.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/nodewidget.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/painters/wirepainter.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/port.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/truthtable.dart';
import 'package:flutter/foundation.dart'; // for listEquals
import 'dart:math';

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
  final SimulatorMode mode;

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
    this.mode = SimulatorMode.practice,
  });

  @override
  State<LogicEditorPage> createState() => _LogicEditorPageState();
}

enum SimulatorMode {
  practice, // single gate
  level, // progression
}

class _LogicEditorPageState extends State<LogicEditorPage> {
  bool isSolved = false;
  EditorModel model = EditorModel();

  void _resetNodesSafely() {
    // clear old nodes
    model.nodes.clear();

    // re-add output node safely
    _seedExample();
  }

  void resetNodes() {
    switchNum = 0;
    model = EditorModel();

    model.nodes.clear();

    _seedExample();

    setState(() {});
  }

  void resetTruthValues() {
    s1.truthvalue = generateTruthValues(0, "A");
    s2.truthvalue = generateTruthValues(0, "B");
    s3.truthvalue = generateTruthValues(0, "C");
    s4.truthvalue = generateTruthValues(0, "D");
    s5.truthvalue = generateTruthValues(0, "E");

    not1.truthvalue = [];
  }

  void resetPortValues() {
    for (var node in model.nodes.values) {
      for (var port in node.ports.values) {
        port.value = false;
      }
    }
  }

  int switchNum = 0;

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
      position: const Offset(10, 10), // position of node
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
      position: const Offset(10, 80),
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
      position: const Offset(9, 150),
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
      label: 'Output',
      position: const Offset(150, 90),
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Logic Gate Simulator',
          style: TextStyle(fontSize: 20, color: Colors.black),
          strutStyle: StrutStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Tooltip(
            message: 'Close',
            child: IconButton(
              icon: Icon(Icons.close_rounded, color: Colors.black),
              iconSize: 25,
              onPressed: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: Border.fromBorderSide(BorderSide.none),
                      title: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to close?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true); // confirm
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false); // cancel
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  Navigator.pop(context); // dito lang mag close
                }
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Container(
            color: const Color.fromARGB(255, 206, 204, 204),
            child: Center(
              child: isMobile
                  ? Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
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
                                SizedBox(
                                  height: 180,

                                  child: Container(
                                    color: Colors.white,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          listEquals(
                                                not1.truthvalue,
                                                widget.ExpecOut,
                                              )
                                              ? 'assets/images/Robot_celebrates_logic_puzzle_success.png' //
                                              : 'assets/images/robotn.png',
                                          height: 140,
                                        ),
                                        Positioned(
                                          top: 10,
                                          child: Container(
                                            width: 330,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 3,
                                              ),
                                            ),
                                            child: Text(
                                              (s1.truthvalue.length ==
                                                      widget.ExpecOut.length)
                                                  ? (listEquals(
                                                          not1.truthvalue,
                                                          widget.ExpecOut,
                                                        )
                                                        ? 'Good job! The output is correct means you chose gates correctly.'
                                                        : 'Good! the output length is correct, now use correct gates to do the expected output')
                                                  : (pow(2, switchNum + 1) <
                                                        widget.ExpecOut.length)
                                                  ? "Let’s use the switches to get ${widget.ExpecOut} as Expected Output "
                                                  : 'Output length is more than expected output length, please restart',

                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),

                                        listEquals(
                                              not1.truthvalue,
                                              widget.ExpecOut,
                                            )
                                            ? Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    13,
                                                  ),

                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (widget.mode ==
                                                          SimulatorMode.level) {
                                                        // NEXT LEVEL
                                                        Get.off(
                                                          () => widget.nextPage,
                                                        );
                                                      } else {
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                Dashboard(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      side: BorderSide(
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              0,
                                                              0,
                                                              0,
                                                            ),
                                                      ),

                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                            255,
                                                            255,
                                                            149,
                                                            0,
                                                          ),

                                                      foregroundColor:
                                                          Colors.white,
                                                      minimumSize: Size(
                                                        isMobile
                                                            ? 130
                                                            : 165, //  width
                                                        isMobile
                                                            ? 40
                                                            : 50, //  height
                                                      ),

                                                      shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            206,
                                                            204,
                                                            204,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              25,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      widget.mode ==
                                                              SimulatorMode
                                                                  .level
                                                          ? "Proceed to Next Level"
                                                          : "Good job!",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 12,

                          child: Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanDown: (d) {
                                  setState(() {});
                                  //mouse click
                                  // if starting drag on a port -> start connection
                                  final pr = _hitTestPort(d.globalPosition);
                                  if (pr != null &&
                                      pr.type == PortType.output) {
                                    // iof click to output port
                                    model.startConnection(
                                      pr,
                                      _globalToLocal(d.globalPosition),
                                    );
                                  }
                                  setState(() {
                                    toggleOutput1Ports();
                                  });
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
                                  setState(() {
                                    toggleOutput1Ports();
                                  });
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
                                          (canvasKey.currentContext
                                                      ?.findRenderObject()
                                                  as RenderBox?)
                                              ?.localToGlobal(last) ??
                                          Offset.zero;
                                      target = _hitTestPort(globalLast);
                                    }
                                    if (target != null &&
                                        target.type == PortType.input) {
                                      model.finishConnection(target);
                                    } else {
                                      model.cancelConnection();
                                    }
                                  }
                                  setState(() {
                                    toggleOutput1Ports();
                                  });
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
                                  setState(() {
                                    toggleOutput1Ports();
                                  });
                                },
                                child: Container(
                                  key: canvasKey,
                                  color: Colors.white,
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
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onPanUpdate: (d) {
                                                setState(() {
                                                  node.position += d.delta;
                                                  model.propagateFromPort(
                                                    PortRef(
                                                      's1',
                                                      'out',
                                                      PortType.output,
                                                    ),
                                                  );
                                                });
                                                model.notifyListeners();
                                              },
                                              child: NodeWidget(
                                                node: node,
                                                model: model,
                                              ),
                                            ),
                                          ),
                                        // optionally draw connecting temporary line
                                        if (model.connectingFrom != null &&
                                            model.currentDragPosition != null)
                                          Positioned.fill(
                                            child: IgnorePointer(
                                              child: CustomPaint(
                                                painter: TempLinePainter(
                                                  model: model,
                                                ),
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
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        if (isMobile) ...[
                                          SizedBox(width: 10),
                                          FloatingActionButton.extended(
                                            heroTag: 'dashboardBtn',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LoadingToDashboard(),
                                                ),
                                              );
                                            },
                                            label: Text('Dashboard'),
                                            icon: Icon(Icons.dashboard),
                                          ),
                                        ],
                                        SizedBox(width: 10),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            model.clearAll(
                                              not1,
                                            ); // nodes + wires
                                            resetPortValues(); // 🔥 lights OFF
                                            resetTruthValues(); // 🔥 table reset

                                            switchNum = 0;

                                            setState(() {});
                                          },
                                          label: const Text('RESET'),
                                        ),
                                        SizedBox(width: 10),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            if (listEquals(
                                              not1.truthvalue,
                                              widget.ExpecOut,
                                            )) {
                                              String gateName =
                                                  widget.allowedGates.first;
                                              markGateAsSolved(gateName);

                                              // (optional) existing dialog mo
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,

                                                    title: Text(
                                                      "GREAT JOB!",
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2,
                                                        fontSize: 17,
                                                        color: Colors.green,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: Text(
                                                      "You got the correct expected output",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    actions: [
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                context,
                                                              ),
                                                          child: Text(
                                                            "OK",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            25,
                                                          ),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text(
                                                      "TRY AGAIN",
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2,
                                                        fontSize: 17,
                                                        color: Colors.red,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: Text(
                                                      "You did not meet the expected output",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    actions: [
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                context,
                                                              ),
                                                          child: Text(
                                                            "OK",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
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
                                        const SizedBox(width: 10),
                                        // ------------------- ADD SWITCH -------------------
                                        FloatingActionButton.extended(
                                          heroTag: 'addSwitch',
                                          onPressed: () {
                                            if (switchNum < 3) {
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
                                                  s1.truthvalue =
                                                      generateTruthValues(
                                                        switchNum,
                                                        "A",
                                                      );
                                                });
                                                setState(() {
                                                  s2.truthvalue =
                                                      generateTruthValues(
                                                        switchNum,
                                                        "B",
                                                      );
                                                });
                                                setState(() {
                                                  s3.truthvalue =
                                                      generateTruthValues(
                                                        switchNum,
                                                        "C",
                                                      );
                                                });
                                              });
                                              setState(() {
                                                s4.truthvalue =
                                                    generateTruthValues(
                                                      switchNum,
                                                      "D",
                                                    );
                                              });
                                              setState(() {
                                                s5.truthvalue =
                                                    generateTruthValues(
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
                                        const SizedBox(width: 8),
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
                                                label: 'Annd',
                                                position: const Offset(
                                                  120,
                                                  120,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      90,
                                                      25,
                                                    ),
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
                                        if (gateAllowed('AND'))
                                          const SizedBox(width: 8),

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
                                                label: 'Ooor',
                                                position: const Offset(
                                                  120,
                                                  220,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      25,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'OR GATE',
                                              child: Image.asset(
                                                'assets/images/Ooor.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('OR'))
                                          const SizedBox(width: 8),

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
                                                label: 'Noot',
                                                position: const Offset(
                                                  120,
                                                  320,
                                                ),
                                                ports: {
                                                  'in': Port(
                                                    id: 'in',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      20,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      20,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'NOT GATE',
                                              child: Image.asset(
                                                'assets/images/Noot.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('NOT'))
                                          const SizedBox(width: 8),

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
                                                label: 'Naand',
                                                position: const Offset(
                                                  120,
                                                  420,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      25,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'NAND GATE',
                                              child: Image.asset(
                                                'assets/images/Naand.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('NAND'))
                                          const SizedBox(width: 8),

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
                                                label: 'Noor',
                                                position: const Offset(
                                                  120,
                                                  520,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      25,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'NOR GATE',
                                              child: Image.asset(
                                                'assets/images/Noor.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('NOR'))
                                          const SizedBox(width: 8),

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
                                                label: 'Xoor',
                                                position: const Offset(
                                                  350,
                                                  190,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      25,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'XOR GATE',
                                              child: Image.asset(
                                                'assets/images/Xoor.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('XOR'))
                                          const SizedBox(width: 8),

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
                                                label: 'Xnoor',
                                                position: const Offset(
                                                  350,
                                                  320,
                                                ),
                                                ports: {
                                                  'a': Port(
                                                    id: 'a',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      10,
                                                    ),
                                                  ),
                                                  'b': Port(
                                                    id: 'b',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      40,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      25,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'XNOR GATE',
                                              child: Image.asset(
                                                'assets/images/Xnoor.png',
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        if (gateAllowed('XNOR'))
                                          const SizedBox(width: 8),

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
                                                label: 'Bufffer',
                                                position: const Offset(
                                                  350,
                                                  440,
                                                ),
                                                ports: {
                                                  'in': Port(
                                                    id: 'in',
                                                    type: PortType.input,
                                                    localOffset: const Offset(
                                                      0,
                                                      20,
                                                    ),
                                                  ),
                                                  'out': Port(
                                                    id: 'out',
                                                    type: PortType.output,
                                                    localOffset: const Offset(
                                                      120,
                                                      20,
                                                    ),
                                                  ),
                                                },
                                              );
                                              model.addNode(n);
                                            },
                                            label: Tooltip(
                                              message: 'BUFFER GATE',
                                              child: Image.asset(
                                                'assets/images/Bufffer.png',
                                                height: 40,
                                              ),
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
                    )
                  : Row(
                      children: [
                        Expanded(flex: 2, child: _buildLeftSide()),
                        Expanded(flex: 3, child: _buildCanvas()),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  void toggleOutput1Ports() {
    for (int i = 0; i < 12; i++) {
      // repeat same number of cycles you had
      model.toggleSwitch("s1");
      model.toggleSwitch("s2");
      model.toggleSwitch("s3");
      model.toggleSwitch("s4");
      model.toggleSwitch("s5");
    }
  }

  Widget _buildCanvas() {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanDown: (d) {
            final pr = _hitTestPort(d.globalPosition);
            if (pr != null && pr.type == PortType.output) {
              model.startConnection(pr, _globalToLocal(d.globalPosition));
            }
            setState(() {
              toggleOutput1Ports();
            });
          },
          onPanUpdate: (d) {
            if (model.connectingFrom != null) {
              model.updateConnectionDrag(_globalToLocal(d.globalPosition));
            }
            setState(() {
              toggleOutput1Ports();
            });
          },
          onPanEnd: (d) {
            if (model.connectingFrom != null) {
              final last = model.currentDragPosition;

              PortRef? target;

              if (last != null) {
                final box =
                    canvasKey.currentContext?.findRenderObject() as RenderBox?;
                if (box != null) {
                  final global = box.localToGlobal(last);
                  target = _hitTestPort(global);
                }
              }

              if (target != null && target.type == PortType.input) {
                model.finishConnection(target); // CREATE WIRE
              } else {
                model.cancelConnection(); //  cancel
              }
            }

            setState(() {
              toggleOutput1Ports();
            });
          },
          child: Container(
            key: canvasKey,
            color: Colors.white,
            child: CustomPaint(
              painter: WirePainter(model: model),
              size: Size.infinite,
              child: Stack(
                children: [
                  if (model.connectingFrom != null &&
                      model.currentDragPosition != null)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: TempLinePainter(model: model),
                        ),
                      ),
                    ),
                  for (final node in model.nodes.values)
                    Positioned(
                      left: node.position.dx,
                      top: node.position.dy,
                      child: Listener(
                        onPointerMove: (event) {
                          if (model.connectingFrom != null) return;
                          setState(() {
                            node.position += event.delta;
                          });
                        },
                        child: NodeWidget(node: node, model: model),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 120,
          bottom: 12,

          child: SingleChildScrollView(
            child: Column(
              children: [
                FloatingActionButton.extended(
                  heroTag: '✅',
                  onPressed: () {
                    model.clearAll(not1); // nodes + wires
                    resetPortValues(); // 🔥 lights OFF
                    resetTruthValues(); // 🔥 table reset

                    switchNum = 0;

                    setState(() {});
                  },
                  label: const Text('RESET'),
                ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  heroTag: '✅',
                  onPressed: () {
                    if (listEquals(not1.truthvalue, widget.ExpecOut)) {
                      String gateName = widget.allowedGates.first;
                      markGateAsSolved(gateName);

                      // (optional) existing dialog mo
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,

                            title: Text(
                              "GREAT JOB!",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                fontSize: 17,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "You got the correct expected output",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Center(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(25),
                            ),
                            backgroundColor: Colors.white,
                            title: Text(
                              "TRY AGAIN",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                fontSize: 17,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "You did not meet the expected output",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                                fontSize: 15,
                              ),
                            ),
                            actions: [
                              Center(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
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
                    if (switchNum < 3) {
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
                          s1.truthvalue = generateTruthValues(switchNum, "A");
                        });
                        setState(() {
                          s2.truthvalue = generateTruthValues(switchNum, "B");
                        });
                        setState(() {
                          s3.truthvalue = generateTruthValues(switchNum, "C");
                        });
                      });
                      setState(() {
                        s4.truthvalue = generateTruthValues(switchNum, "D");
                      });
                      setState(() {
                        s5.truthvalue = generateTruthValues(switchNum, "E");
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
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'AND',
                        label: 'Annd',
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
                      child: Image.asset('assets/images/Annd.png', height: 40),
                    ),
                  ),
                if (gateAllowed('AND')) const SizedBox(height: 8),

                // ------------------- OR -------------------
                if (gateAllowed('OR'))
                  FloatingActionButton.extended(
                    heroTag: 'addOr',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'OR',
                        label: 'Ooor',
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
                    label: Tooltip(
                      message: 'OR GATE',
                      child: Image.asset('assets/images/Ooor.png', height: 40),
                    ),
                  ),
                if (gateAllowed('OR')) const SizedBox(height: 8),

                // ------------------- NOT -------------------
                if (gateAllowed('NOT'))
                  FloatingActionButton.extended(
                    heroTag: 'addNot',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'NOT',
                        label: 'Noot',
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
                    label: Tooltip(
                      message: 'NOT GATE',
                      child: Image.asset('assets/images/Noot.png', height: 40),
                    ),
                  ),
                if (gateAllowed('NOT')) const SizedBox(height: 8),

                // ------------------- NAND -------------------
                if (gateAllowed('NAND'))
                  FloatingActionButton.extended(
                    heroTag: 'addNand',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'NAND',
                        label: 'Naand',
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
                    label: Tooltip(
                      message: 'NAND GATE',
                      child: Image.asset('assets/images/Naand.png', height: 40),
                    ),
                  ),
                if (gateAllowed('NAND')) const SizedBox(height: 8),

                // ------------------- NOR -------------------
                if (gateAllowed('NOR'))
                  FloatingActionButton.extended(
                    heroTag: 'addNor',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'NOR',
                        label: 'Noor',
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
                    label: Tooltip(
                      message: 'NOR GATE',
                      child: Image.asset('assets/images/Noor.png', height: 40),
                    ),
                  ),
                if (gateAllowed('NOR')) const SizedBox(height: 8),

                // ------------------- XOR -------------------
                if (gateAllowed('XOR'))
                  FloatingActionButton.extended(
                    heroTag: 'addXor',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'XOR',
                        label: 'Xoor',
                        position: const Offset(350, 190),
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
                    label: Tooltip(
                      message: 'XOR GATE',
                      child: Image.asset('assets/images/Xoor.png', height: 40),
                    ),
                  ),
                if (gateAllowed('XOR')) const SizedBox(height: 8),

                // ------------------- XNOR -------------------
                if (gateAllowed('XNOR'))
                  FloatingActionButton.extended(
                    heroTag: 'addXnor',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'XNOR',
                        label: 'Xnoor',
                        position: const Offset(350, 320),
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
                    label: Tooltip(
                      message: 'XNOR GATE',
                      child: Image.asset('assets/images/Xnoor.png', height: 40),
                    ),
                  ),
                if (gateAllowed('XNOR')) const SizedBox(height: 8),

                // ------------------- BUFFER -------------------
                if (gateAllowed('BUFFER'))
                  FloatingActionButton.extended(
                    heroTag: 'addBuffer',
                    onPressed: () {
                      final id = 'g${DateTime.now().microsecondsSinceEpoch}';
                      final n = Node(
                        id: id,
                        kind: 'BUFFER',
                        label: 'Bufffer',
                        position: const Offset(350, 440),
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
                    label: Tooltip(
                      message: 'BUFFER GATE',
                      child: Image.asset(
                        'assets/images/Bufffer.png',
                        height: 40,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftSide() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 206, 204, 204),
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
          Container(
            height: 387,
            color: const Color.fromARGB(255, 206, 204, 204),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  listEquals(not1.truthvalue, widget.ExpecOut)
                      ? 'assets/images/Robot_celebrates_logic_puzzle_success.png' //
                      : 'assets/images/robotn.png',
                  height: 235,
                ),
                Positioned(
                  top: 85,
                  child: Container(
                    width: 340,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 204, 204),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      (s1.truthvalue.length == widget.ExpecOut.length)
                          ? (listEquals(not1.truthvalue, widget.ExpecOut)
                                ? 'Good job! The output is correct means you chose gates correctly.'
                                : 'Good! the output length is correct, now use correct gates to do the expected output')
                          : (pow(2, switchNum + 1) < widget.ExpecOut.length)
                          ? "Let’s use the switches to get ${widget.ExpecOut} as Expected Output "
                          : 'Output length is more than expected output length, please restart',

                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                listEquals(not1.truthvalue, widget.ExpecOut)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(13),

                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.mode == SimulatorMode.level) {
                                Get.off(() => widget.nextPage);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoadingToDashboard(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),

                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                149,
                                0,
                              ),

                              foregroundColor: Colors.white,
                              minimumSize: Size(
                                isMobile ? 130 : 165, //  width
                                isMobile ? 40 : 50, //  height
                              ),

                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              widget.mode == SimulatorMode.level
                                  ? "Proceed to Next Level"
                                  : "Good job!",
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingToDashboard extends StatefulWidget {
  const LoadingToDashboard({super.key});

  @override
  State<LoadingToDashboard> createState() => _LoadingToDashboardState();
}

class _LoadingToDashboardState extends State<LoadingToDashboard> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: CircularProgressIndicator(), // 🔥 ito na yun
      ),
    );
  }
}
