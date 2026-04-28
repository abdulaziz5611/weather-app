import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/hourly_forecast.dart';

class PrecipitationCard extends StatelessWidget {
  final DailyForecast day;
  final List<HourlyForecast> hours;

  const PrecipitationCard({super.key, required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    final maxProb = hours.isEmpty
        ? 0
        : hours.map((h) => h.precipitationProbability).reduce((a, b) => a > b ? a : b);

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PRECIPITATION', style: AppTypography.label),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                day.precipitationSum.toStringAsFixed(day.precipitationSum < 10 ? 1 : 0),
                style: AppTypography.numericLarge.copyWith(fontSize: 38),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('mm', style: AppTypography.secondary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('$maxProb% chance', style: AppTypography.secondary),
          const SizedBox(height: 14),
          if (hours.isNotEmpty) _Bars(hours: hours),
        ],
      ),
    );
  }
}

class _Bars extends StatelessWidget {
  final List<HourlyForecast> hours;

  const _Bars({required this.hours});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final h in hours)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: FractionallySizedBox(
                  heightFactor: (h.precipitationProbability / 100).clamp(0.04, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentInfo.withValues(
                        alpha: 0.4 + 0.5 * (h.precipitationProbability / 100),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
