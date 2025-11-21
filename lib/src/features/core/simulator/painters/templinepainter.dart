import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';

class TempLinePainter extends CustomPainter {
  final EditorModel model;
  TempLinePainter({required this.model}) : super(repaint: model);

  @override
  void paint(Canvas canvas, Size size) {
    if (model.connectingFrom == null || model.currentDragPosition == null)
      return;
    final fromRef = model.connectingFrom!;
    final fromNode = model.nodes[fromRef.nodeId];
    if (fromNode == null) return;
    final fromPort = fromNode.ports[fromRef.portId];
    if (fromPort == null) return;
    final p1 = fromNode.position + fromPort.localOffset + Offset(12, 12);
    final p2 = model.currentDragPosition!;
    final path = Path();
    final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(mid.dx, p1.dy, mid.dx, mid.dy);
    path.quadraticBezierTo(mid.dx, p2.dy, p2.dx, p2.dy);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black38
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(p2, 6, Paint()..color = Colors.black38);
  }

  @override
  bool shouldRepaint(covariant TempLinePainter oldDelegate) => true;
}
