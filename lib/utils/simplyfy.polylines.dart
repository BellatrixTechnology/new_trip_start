import 'dart:math';

class PolylineSimplifier {
  late List<Point> _points;

  PolylineSimplifier(List<Point> points) {
    _points = points;
  }

  List<Point> simplify(double tolerance) {
    if (_points == null || _points.length < 3) {
      return _points;
    }

    int firstIndex = 0;
    int lastIndex = _points.length - 1;
    List<int> indices = [firstIndex, lastIndex];

    _simplifySection(firstIndex, lastIndex, tolerance, indices);

    indices.sort();

    List<Point> simplifiedPoints = [];
    for (int i = 0; i < indices.length; i++) {
      int index = indices[i];
      simplifiedPoints.add(_points[index]);
    }

    return simplifiedPoints;
  }

  void _simplifySection(
      int firstIndex, int lastIndex, double tolerance, List<int> indices) {
    Point firstPoint = _points[firstIndex];
    Point lastPoint = _points[lastIndex];

    if (lastIndex - firstIndex <= 1) {
      return;
    }

    double maxDistance = 0;
    int maxIndex = firstIndex + 1;

    for (int i = firstIndex + 1; i < lastIndex; i++) {
      double distance = _distanceToLine(_points[i], firstPoint, lastPoint);
      if (distance > maxDistance) {
        maxDistance = distance;
        maxIndex = i;
      }
    }

    if (maxDistance > tolerance) {
      indices.add(maxIndex);
      _simplifySection(firstIndex, maxIndex, tolerance, indices);
      _simplifySection(maxIndex, lastIndex, tolerance, indices);
    }
  }

  double _distanceToLine(Point point, Point lineStart, Point lineEnd) {
    var a = point.x - lineStart.x;
    var b = point.y - lineStart.y;
    var c = lineEnd.x - lineStart.x;
    var d = lineEnd.y - lineStart.y;

    var dot = a * c + b * d;
    var lenSq = c * c + d * d;
    var param = dot / lenSq;

    var xx, yy;

    if (param < 0) {
      xx = lineStart.x;
      yy = lineStart.y;
    } else if (param > 1) {
      xx = lineEnd.x;
      yy = lineEnd.y;
    } else {
      xx = lineStart.x + param * c;
      yy = lineStart.y + param * d;
    }

    var dx = point.x - xx;
    var dy = point.y - yy;

    return sqrt(dx * dx + dy * dy);
  }
}
