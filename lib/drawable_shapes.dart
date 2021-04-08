import 'dart:ui';

class Shape {} // Origin class for all the shapes

// A curved line consisting of points
class ColoredPath extends Shape {
  final List<Offset> points = [];
  final paint = Paint();
  ColoredPath(Color color) {
    this.paint
      ..color = color
      ..isAntiAlias = true
      ..strokeWidth = 3.0;
  }
  void add(Offset point) => points.add(point);
}

// Contains a path of eraser tool
class EraserPath extends ColoredPath {
  static const _backgroundColorCode =
      0xFFFAFAFA; // This is a default color for app's background
  EraserPath() : super(Color(_backgroundColorCode)) {
    super.paint.strokeWidth = 40;
  }
}

// A straight section defined by 2 points
class Line extends Shape {
  Offset p1, p2;
  final paint = Paint();
  Line(Color color) {
    this.paint
      ..color = color
      ..isAntiAlias = true
      ..strokeWidth = 3.0;
  }
}

// Rectangle
class Rectangle extends Shape {
  Rect rect;
  double left, top;
  /* Because of the implementation left and top values 
      have to be saved inside of a rectangle */
  final paint = Paint();
  Rectangle(Color color) {
    this.paint
      ..color = color
      ..isAntiAlias = true
      ..strokeWidth = 3.0;
  }
}
