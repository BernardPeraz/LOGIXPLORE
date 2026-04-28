import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/portcircle.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';

class NodeWidget extends StatelessWidget {
  final Node node;
  final EditorModel model;
  const NodeWidget({super.key, required this.node, required this.model});
  Color _getGateColor(Node node) {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    const double portRadius = 5; // adjust depende sa size ng PortCircle

    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: portRadius > 0
              ? [
                  BoxShadow(
                    color: Colors.white, // FIX
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ]
              : null,
        ),

        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/${node.label}.png',
                height: 63,
                width: 100,
                color: _getGateColor(node),
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) {
                  print("IMAGE ERROR: $error");
                  return const Icon(Icons.error);
                },
              ),
            ),
            // ports
            for (final port in node.ports.values)
              Positioned(
                left: port.localOffset.dx,
                top: port.localOffset.dy,
                child: GestureDetector(
                  onPanStart: (d) {
                    // if starting from output start connection
                    if (port.type == PortType.output) {
                      final gpos = (context.findRenderObject() as RenderBox)
                          .localToGlobal(
                            port.localOffset +
                                node.position +
                                const Offset(portRadius, portRadius),
                          );
                    }
                  },
                  onPanUpdate: (d) {
                    final gpos = (context.findRenderObject() as RenderBox)
                        .localToGlobal(
                          port.localOffset +
                              node.position +
                              const Offset(portRadius, portRadius),
                        );
                  },
                  onPanEnd: (d) {
                    // finish by checking nearest input at release
                    // We'll rely on global gesture detection in parent; do nothing here
                  },
                  onTap: () {
                    // toggle switches by tapping their output port (switch behavior)
                    if (node.kind == 'SWITCH' && port.type == PortType.output) {
                      model.toggleSwitch(node.id);
                    }
                  },
                  child: PortCircle(port: port),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _nodeColor(Node n) {
    switch (n.kind) {
      case 'SWITCH':
        return Colors.orange.shade100;
      case 'AND':
        return Colors.lightBlue.shade100;
      case 'OR':
        return Colors.green.shade100;
      case 'NOT':
        return Colors.purple.shade100;
      case 'NAND':
        return Colors.red.shade100;
      case 'NOR':
        return Colors.teal.shade100;
      case 'XOR':
        return Colors.yellow.shade100;
      case 'XNOR':
        return Colors.pink.shade100;
      case 'BUFFER':
        return Colors.cyan.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
}
