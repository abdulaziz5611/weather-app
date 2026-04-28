import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/air_quality.dart';

class AirQualityCard extends StatelessWidget {
  final AirQuality airQuality;

  const AirQualityCard({super.key, required this.airQuality});

  @override
  Widget build(BuildContext context) {
    final aqi = airQuality.aqi;
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AIR QUALITY', style: AppTypography.label),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(aqi.toString(),
                  style: AppTypography.numericLarge.copyWith(fontSize: 38)),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_AqiHelper.label(aqi),
                    style: AppTypography.headline
                        .copyWith(color: _AqiHelper.color(aqi))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ScaleBar(aqi: aqi),
          const SizedBox(height: 16),
          Row(
            children: [
              _Pollutant(label: 'PM2.5', value: airQuality.pm25),
              _Pollutant(label: 'PM10', value: airQuality.pm10),
              _Pollutant(label: 'O₃', value: airQuality.ozone),
              _Pollutant(label: 'NO₂', value: airQuality.nitrogenDioxide),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScaleBar extends StatelessWidget {
  final int aqi;
  const _ScaleBar({required this.aqi});

  @override
  Widget build(BuildContext context) {
    final position = (aqi / 120).clamp(0.0, 1.0);
    return SizedBox(
      height: 10,
      child: LayoutBuilder(builder: (ctx, c) {
        final w = c.maxWidth;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.aqiGood,
                    AppColors.aqiFair,
                    AppColors.aqiModerate,
                    AppColors.aqiPoor,
                    AppColors.aqiVeryPoor,
                    AppColors.aqiHazardous,
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Positioned(
              left: (w * position) - 5,
              top: -2,
              child: Container(
                width: 10,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: AppColors.background, width: 1),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Pollutant extends StatelessWidget {
  final String label;
  final double value;

  const _Pollutant({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTypography.label),
          const SizedBox(height: 4),
          Text(
            value.round().toString(),
            style: AppTypography.numeric.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _AqiHelper {
  _AqiHelper._();

  static String label(int aqi) {
    if (aqi < 20) return 'Good';
    if (aqi < 40) return 'Fair';
    if (aqi < 60) return 'Moderate';
    if (aqi < 80) return 'Poor';
    if (aqi < 100) return 'Very Poor';
    return 'Hazardous';
  }

  static Color color(int aqi) {
    if (aqi < 20) return AppColors.aqiGood;
    if (aqi < 40) return AppColors.aqiFair;
    if (aqi < 60) return AppColors.aqiModerate;
    if (aqi < 80) return AppColors.aqiPoor;
    if (aqi < 100) return AppColors.aqiVeryPoor;
    return AppColors.aqiHazardous;
  }
}
