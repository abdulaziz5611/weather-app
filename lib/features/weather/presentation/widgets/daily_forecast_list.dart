import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../../settings/domain/entities/unit_preferences.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/daily_forecast.dart';

class DailyForecastList extends StatelessWidget {
  final List<DailyForecast> daily;
  final ValueChanged<int>? onDayTap;

  const DailyForecastList({super.key, required this.daily, this.onDayTap});

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<SettingsCubit>().state.tempUnit;
    final shown = daily.take(10).toList();
    final overallMin = shown.map((d) => d.temperatureMin).reduce(min);
    final overallMax = shown.map((d) => d.temperatureMax).reduce(max);

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded,
                  size: 13, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('10-DAY FORECAST', style: AppTypography.label),
            ],
          ),
          const SizedBox(height: 6),
          ...shown.asMap().entries.map((entry) {
            final i = entry.key;
            final d = entry.value;
            return InkWell(
              onTap: onDayTap == null ? null : () => onDayTap!(i),
              borderRadius: BorderRadius.circular(8),
              child: _DailyRow(
                label: i == 0 ? 'Today' : _weekdayShort(d.date),
                day: d,
                overallMin: overallMin,
                overallMax: overallMax,
                unit: unit,
              ),
            );
          }),
        ],
      ),
    );
  }

  String _weekdayShort(DateTime d) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[d.weekday - 1];
  }
}

class _DailyRow extends StatelessWidget {
  final String label;
  final DailyForecast day;
  final double overallMin;
  final double overallMax;
  final TempUnit unit;

  const _DailyRow({
    required this.label,
    required this.day,
    required this.overallMin,
    required this.overallMax,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final range = overallMax - overallMin;
    final dayStart = range == 0 ? 0.0 : (day.temperatureMin - overallMin) / range;
    final dayEnd = range == 0 ? 1.0 : (day.temperatureMax - overallMin) / range;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(label, style: AppTypography.body)),
          WeatherIcon(condition: day.condition, size: 20),
          const SizedBox(width: 12),
          SizedBox(
            width: 36,
            child: Text(day.temperatureMin.toTemp(unit),
                style: AppTypography.secondary, textAlign: TextAlign.right),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(builder: (ctx, c) {
              final w = c.maxWidth;
              return SizedBox(
                height: 4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.textMuted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Positioned(
                      left: w * dayStart,
                      width: w * (dayEnd - dayStart).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.accentInfo,
                              AppColors.accentWarn,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(day.temperatureMax.toTemp(unit),
                style: AppTypography.body, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
