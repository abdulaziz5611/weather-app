import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../types/weather_condition.dart';

export '../types/weather_condition.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;
  final Color? color;

  const WeatherIcon({
    super.key,
    required this.condition,
    this.size = 24,
    this.color,
  });

  IconData get _icon {
    switch (condition) {
      case WeatherCondition.clear:
        return Icons.wb_sunny_rounded;
      case WeatherCondition.partlyCloudy:
        return Icons.cloud_queue_rounded;
      case WeatherCondition.cloudy:
        return Icons.cloud_rounded;
      case WeatherCondition.rain:
        return Icons.water_drop_rounded;
      case WeatherCondition.snow:
        return Icons.ac_unit_rounded;
      case WeatherCondition.thunder:
        return Icons.flash_on_rounded;
      case WeatherCondition.fog:
        return Icons.foggy;
      case WeatherCondition.moon:
        return Icons.nightlight_round;
      case WeatherCondition.moonCloud:
        return Icons.bedtime_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(_icon, size: size, color: color ?? AppColors.textPrimary);
  }
}
