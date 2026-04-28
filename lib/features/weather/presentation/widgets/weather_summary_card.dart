import 'package:flutter/material.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../domain/entities/weather_forecast.dart';

class WeatherSummaryCard extends StatelessWidget {
  final WeatherForecast forecast;

  const WeatherSummaryCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          WeatherIcon(condition: forecast.current.condition, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(_buildSummary(forecast), style: AppTypography.body),
          ),
        ],
      ),
    );
  }

  String _buildSummary(WeatherForecast f) {
    final today = f.daily.first;
    if (today.precipitationSum > 1) {
      return 'Showers expected today, ${today.precipitationSum.toStringAsFixed(1)} mm. '
          'Highs near ${today.temperatureMax.round()}°.';
    }
    return 'Mild conditions today. '
        'High ${today.temperatureMax.round()}°, low ${today.temperatureMin.round()}°.';
  }
}
