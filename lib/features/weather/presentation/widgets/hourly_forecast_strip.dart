import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../../settings/domain/entities/unit_preferences.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/hourly_forecast.dart';

class HourlyForecastStrip extends StatelessWidget {
  final List<HourlyForecast> hourly;

  const HourlyForecastStrip({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<SettingsCubit>().state.tempUnit;
    final now = DateTime.now();
    final currentHourIndex = hourly.indexWhere((h) =>
        h.time.year == now.year &&
        h.time.month == now.month &&
        h.time.day == now.day &&
        h.time.hour == now.hour);
    final start = currentHourIndex >= 0 ? currentHourIndex : 0;
    final visible = hourly.skip(start).take(24).toList();

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
              itemCount: visible.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, i) {
                final h = visible[i];
                return _HourlyItem(
                  label: i == 0 ? 'Now' : h.time.toHourLabel(),
                  hour: h,
                  unit: unit,
                );
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
  final TempUnit unit;

  const _HourlyItem({required this.label, required this.hour, required this.unit});

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
        Text(hour.temperature.toTemp(unit), style: AppTypography.body),
      ],
    );
  }
}
