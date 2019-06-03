import 'package:flutter/material.dart';
import 'dart:math';

class Styles {
  static Color randomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  static get screelerColor => Colors.amber[800];
}