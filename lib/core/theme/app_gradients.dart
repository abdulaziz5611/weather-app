import 'package:flutter/material.dart';

enum TimeOfDayPeriod { morning, afternoon, evening, night }

class AppGradients {
  AppGradients._();

  static const morning = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFFFB07A),
      Color(0xFFC58CB0),
      Color(0xFF3D2A6B),
      Color(0xFF1A1338),
    ],
    stops: [0.0, 0.4, 0.75, 1.0],
  );

  static const afternoon = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF7DB6E8),
      Color(0xFF5990CC),
      Color(0xFF2C4A85),
      Color(0xFF1A2C5C),
    ],
    stops: [0.0, 0.45, 0.8, 1.0],
  );

  static const evening = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFFF8A65),
      Color(0xFFB66BAA),
      Color(0xFF4A2A6B),
      Color(0xFF1F1438),
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  static const night = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A2238),
      Color(0xFF0F1530),
      Color(0xFF080B1F),
      Color(0xFF03050E),
    ],
    stops: [0.0, 0.4, 0.75, 1.0],
  );

  static LinearGradient forPeriod(TimeOfDayPeriod period) {
    switch (period) {
      case TimeOfDayPeriod.morning:
        return morning;
      case TimeOfDayPeriod.afternoon:
        return afternoon;
      case TimeOfDayPeriod.evening:
        return evening;
      case TimeOfDayPeriod.night:
        return night;
    }
  }
}
