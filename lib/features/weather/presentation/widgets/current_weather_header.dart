import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../domain/entities/weather_forecast.dart';

class CurrentWeatherHeader extends StatelessWidget {
  final WeatherForecast forecast;
  final String locationName;

  const CurrentWeatherHeader({
    super.key,
    required this.forecast,
    this.locationName = 'Porto',
  });

  @override
  Widget build(BuildContext context) {
    final current = forecast.current;
    final today = forecast.daily.first;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on_outlined,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text('My Location · Updated now', style: AppTypography.label),
          ],
        ),
        const SizedBox(height: 4),
        Text(locationName, style: AppTypography.title),
        const SizedBox(height: 12),
        Text(current.temperature.toTemp(), style: AppTypography.display),
        const SizedBox(height: 4),
        WeatherIcon(condition: current.condition, size: 40),
        const SizedBox(height: 8),
        Text(WeatherConditionMapper.label(current.condition),
            style: AppTypography.headline),
        Text(
          'H:${today.temperatureMax.toTemp()}  ·  L:${today.temperatureMin.toTemp()}  ·  Feels ${current.feelsLike.toTemp()}',
          style: AppTypography.secondary,
        ),
      ],
    );
  }
}
