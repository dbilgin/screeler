import 'package:flutter/material.dart';
import 'dart:math';

class Styles {
  /// Returns a random [Color].
  static Color randomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  static var mainText = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      decoration: TextDecoration.none);

  static var noteText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      decoration: TextDecoration.none);

  static var normalText = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      decoration: TextDecoration.none);

  /// Screeler's main color.
  static get screelerColor => Colors.red;
}
