import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/hourly_forecast.dart';

class TemperatureChart extends StatelessWidget {
  final List<HourlyForecast> hours;

  const TemperatureChart({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    if (hours.isEmpty) {
      return const SizedBox.shrink();
    }

    final spots = <FlSpot>[
      for (var i = 0; i < hours.length; i++)
        FlSpot(i.toDouble(), hours[i].temperature),
    ];
    final temps = hours.map((h) => h.temperature).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b);
    final maxTemp = temps.reduce((a, b) => a > b ? a : b);
    final padding = ((maxTemp - minTemp) * 0.2).clamp(1.0, 5.0);

    final firstHour = hours.first.time;
    final lastHour = hours.last.time;

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TEMPERATURE', style: AppTypography.label),
              Text(
                '${_hourLabel(firstHour)} → ${_hourLabel(lastHour)}',
                style: AppTypography.label,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (hours.length - 1).toDouble(),
                minY: minTemp - padding,
                maxY: maxTemp + padding,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: (hours.length / 5).clamp(1, hours.length).floorToDouble(),
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= hours.length) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(_hourLabel(hours[i].time), style: AppTypography.label),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.4,
                    color: AppColors.accentWarn,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                        radius: 3,
                        color: AppColors.accentWarn,
                        strokeWidth: 0,
                      ),
                      checkToShowDot: (spot, _) =>
                          spot.x.toInt() % ((hours.length / 6).clamp(1, hours.length).floor()) == 0,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentWarn.withValues(alpha: 0.25),
                          AppColors.accentWarn.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _hourLabel(DateTime t) {
    final h = t.hour == 0 ? 12 : (t.hour > 12 ? t.hour - 12 : t.hour);
    final period = t.hour < 12 ? 'AM' : 'PM';
    return '$h $period';
  }
}
