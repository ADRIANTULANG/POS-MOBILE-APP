import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sizer {
  double height({
    required double height,
    required context,
  }) {
    var h = height * 0.01;
    double result = MediaQuery.of(context).size.height * h;
    return result;
  }

  double width({
    required double width,
    required context,
  }) {
    var h = width * 0.01;
    double result = MediaQuery.of(context).size.width * h;
    return result;
  }

  double font({
    required double fontsize,
    required context,
  }) {
    double result = MediaQuery.of(context).textScaleFactor * fontsize;
    return result;
  }
}
