import 'dart:math';

import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/editor/editormobile.dart';

class WirePainter extends CustomPainter {
  final EditorModel model;
  WirePainter({required this.model}) : super(repaint: model);

  @override
  void paint(Canvas canvas, Size size) {
    final paintOff = Paint()
      ..color = const Color.fromARGB(31, 0, 0, 0)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // draw wires
    for (final w in model.wires.values) {
      final fromNode = model.nodes[w.from.nodeId];
      final toNode = model.nodes[w.to.nodeId];
      if (fromNode == null || toNode == null) continue;
      final fromPort = fromNode.ports[w.from.portId];
      final toPort = toNode.ports[w.to.portId];
      if (fromPort == null || toPort == null) continue;
      final p1 =
          fromNode.position + fromPort.localOffset + const Offset(4.85, 4.85);
      final p2 =
          toNode.position +
          toPort.localOffset +
          const Offset(4.85, 4.85); //center
      final state = fromPort.value;
      final paint = Paint()
        ..color = state ? Colors.red : Colors.black
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      final path = Path();
      // simple curved path
      final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      path.moveTo(p1.dx, p1.dy);
      path.quadraticBezierTo(mid.dx, p1.dy, mid.dx, mid.dy);
      path.quadraticBezierTo(mid.dx, p2.dy, p2.dx, p2.dy);
      canvas.drawPath(path, paint);
      // draw little arrow or dot at target
      canvas.drawCircle(
        p2,
        4,
        Paint()..color = state ? Colors.red : Colors.black26,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WirePainter oldDelegate) => true;
}

class TempLinePainter extends CustomPainter {
  final EditorModel model;
  TempLinePainter({required this.model}) : super(repaint: model);

  @override
  void paint(Canvas canvas, Size size) {
    if (model.connectingFrom == null || model.currentDragPosition == null) {
      return;
    }
    final fromRef = model.connectingFrom!;
    final fromNode = model.nodes[fromRef.nodeId];
    if (fromNode == null) return;
    final fromPort = fromNode.ports[fromRef.portId];
    if (fromPort == null) return;
    final p1 = fromNode.position + fromPort.localOffset;
    final p2 = model.currentDragPosition!;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final distance = sqrt(dx * dx + dy * dy);

    // avoid division by zero
    final unitDx = distance == 0 ? 0 : dx / distance;
    final unitDy = distance == 0 ? 0 : dy / distance;

    // adjust endpoint (para pumasok sa port)
    final adjustedP2 = Offset(p2.dx - unitDx * 3, p2.dy - unitDy * 3);
    final path = Path();
    final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(mid.dx, p1.dy, mid.dx, mid.dy);
    path.quadraticBezierTo(mid.dx, adjustedP2.dy, adjustedP2.dx, adjustedP2.dy);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(adjustedP2, 3, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant TempLinePainter oldDelegate) => true;
}
