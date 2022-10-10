import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  late double _width, _heigth, _diagonal;
  late bool _isTable;

  double get width => _width;
  double get heigth => _heigth;
  double get diagonal => _diagonal;
  bool get isTable => _isTable;

  static Responsive of(BuildContext context) => Responsive(context);
  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _heigth = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_heigth, 2));
    _isTable = size.shortestSide >= 600;
  }

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _heigth * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
