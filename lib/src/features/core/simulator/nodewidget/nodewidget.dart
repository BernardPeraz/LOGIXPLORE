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
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _nodeColor(node),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                node.label,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
        return Colors.orange.shade200;
      case 'AND':
        return Colors.lightBlue.shade100;
      case 'OR':
        return Colors.green.shade100;
      case 'NOT':
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
}
