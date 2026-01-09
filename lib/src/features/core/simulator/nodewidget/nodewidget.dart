import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/nodewidget/portcircle.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/node.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/portref.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/models/porttype.dart';

class NodeWidget extends StatelessWidget {
  final Node node;
  final EditorModel model;
  const NodeWidget({super.key, required this.node, required this.model});

  @override
  Widget build(BuildContext context) {
    final width = 120.0;
    final height = 70.0;
    return SizedBox(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _nodeColor(node),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/' + node.label.toLowerCase() + '.png',
                height: 60,
              ),
            ),
            // ports
            for (final port in node.ports.values)
              Positioned(
                left: port.localOffset.dx - 8,
                top: port.localOffset.dy - 8,
                child: GestureDetector(
                  onPanStart: (d) {
                    // if starting from output start connection
                    if (port.type == PortType.output) {
                      final gpos = (context.findRenderObject() as RenderBox)
                          .localToGlobal(port.localOffset + node.position);
                      model.startConnection(
                        PortRef(node.id, port.id, PortType.output),
                        gpos,
                      );
                    }
                  },
                  onPanUpdate: (d) {
                    final gpos = (context.findRenderObject() as RenderBox)
                        .localToGlobal(port.localOffset + node.position);
                    model.updateConnectionDrag(gpos + d.delta);
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
        return Colors.transparent;
      case 'AND':
        return Colors.transparent;
      case 'OR':
        return Colors.transparent;
      case 'NOT':
        return Colors.transparent;
      case 'NAND':
        return Colors.transparent;
      case 'NOR':
        return Colors.transparent;
      case 'XOR':
        return Colors.transparent;
      case 'XNOR':
        return Colors.transparent;
      case 'BUFFER':
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }
}
