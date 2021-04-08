import 'dart:ui';

import 'package:flutter/material.dart';
import 'drawing_board_painter.dart';
import 'drawable_shapes.dart';
import 'main.dart' show Tool;

extension LastElement<T> on List<T> {
  // Convenience extension for better code readability
  T lastElement() {
    return this[this.length - 1];
  }
}

class DrawingBoard extends StatefulWidget {
  final Color _drawingColor; // Color of the drawn shape
  final Tool _tool;

  DrawingBoard(this._drawingColor, this._tool) : super();

  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  final _shapes = <Shape>[];
  int _numberOfPoints = 0; // Counter for drawing paths

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                // Set the begining point of a shape
                switch (widget._tool) {
                  case Tool.pencil:
                    _shapes.add(ColoredPath(widget._drawingColor));
                    (_shapes.lastElement() as ColoredPath)
                        .add(details.localPosition);
                    break;
                  case Tool.eraser:
                    _shapes.add(EraserPath());
                    (_shapes.lastElement() as EraserPath)
                        .add(details.localPosition);
                    break;
                  case Tool.line:
                    _shapes.add(Line(widget._drawingColor));
                    (_shapes.lastElement() as Line).p1 = details.localPosition;
                    break;
                  case Tool.rectangle:
                    _shapes.add(Rectangle(widget._drawingColor));
                    double top = details.localPosition.dy;
                    double left = details.localPosition.dx;
                    (_shapes.lastElement() as Rectangle).left = left;
                    (_shapes.lastElement() as Rectangle).top = top;
                    break;
                  default:
                    break;
                }
              });
            },
            onPanUpdate: (details) {
              setState(() {
                if (widget._tool == Tool.line) {
                  (_shapes.lastElement() as Line).p2 = details.localPosition;
                } else if (widget._tool == Tool.rectangle) {
                  double bottom = details.localPosition.dy;
                  double right = details.localPosition.dx;
                  var currentRectangle = _shapes.lastElement() as Rectangle;
                  currentRectangle.rect = Rect.fromLTRB(currentRectangle.left,
                      currentRectangle.top, right, bottom);
                } else {
                  if (_numberOfPoints % 2 == 0) {
                    // only 1 out of 2 points is saved to reduce memory consumption
                    (_shapes.lastElement() as ColoredPath)
                        .add(details.localPosition);
                  }
                  ++_numberOfPoints;
                }
              });
            },
            onPanEnd: (details) {
              setState(() {
                _numberOfPoints = 0;
              });
            },
            child: Container(
              child: CustomPaint(
                painter: DrawingBoardPainter(_shapes),
                isComplex: true,
                willChange: true,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            )));
  }
}
