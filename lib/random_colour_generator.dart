import 'dart:math';

import 'package:flutter/material.dart';

class RandomColourGenerator {
  static final Random _random = Random();

  RandomColourGenerator._internal();

  static Color generate() {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextDouble().clamp(0.2, 1.0),
    );
  }
}
