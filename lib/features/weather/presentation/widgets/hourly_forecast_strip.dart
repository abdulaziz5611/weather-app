import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../domain/entities/hourly_forecast.dart';

class HourlyForecastStrip extends StatelessWidget {
  final List<HourlyForecast> hourly;

  const HourlyForecastStrip({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final upcoming = hourly.where((h) => h.time.isAfter(now)).take(23).toList();

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_rounded,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('24-HOUR FORECAST', style: AppTypography.label),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: upcoming.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, i) {
                if (i == 0 && hourly.isNotEmpty) {
                  return _HourlyItem(label: 'Now', hour: hourly.first);
                }
                final h = upcoming[i - 1];
                return _HourlyItem(label: h.time.toHourLabel(), hour: h);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HourlyItem extends StatelessWidget {
  final String label;
  final HourlyForecast hour;

  const _HourlyItem({required this.label, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.label),
        if (hour.precipitationProbability >= 30)
          Text('${hour.precipitationProbability}%',
              style: AppTypography.label.copyWith(color: AppColors.accentInfo))
        else
          const SizedBox(height: 14),
        WeatherIcon(condition: hour.condition, size: 22),
        Text(hour.temperature.toTemp(), style: AppTypography.body),
      ],
    );
  }
}
