import 'package:flutter/material.dart';
import 'dart:ui';

import 'drawable_shapes.dart';

class DrawingBoardPainter extends CustomPainter {
  final List<Shape> shapes;

  DrawingBoardPainter(this.shapes) : super();

  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      if (shape is ColoredPath) {
        canvas.drawPoints(PointMode.polygon, shape.points, shape.paint);
      } else if (shape is Line) {
        canvas.drawLine(shape.p1, shape.p2, shape.paint);
      } else if (shape is Rectangle) {
        canvas.drawRect(shape.rect, shape.paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
