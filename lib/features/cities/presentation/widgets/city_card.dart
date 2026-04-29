import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/time_of_day_helper.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../domain/entities/saved_city.dart';

class CityCard extends StatelessWidget {
  final SavedCity city;
  final VoidCallback? onTap;

  const CityCard({super.key, required this.city, this.onTap});

  @override
  Widget build(BuildContext context) {
    final period = TimeOfDayHelper.current();
    final subtitle = city.admin1 != null && city.admin1!.isNotEmpty
        ? '${city.admin1} · ${city.country}'
        : city.country;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 110,
        decoration: BoxDecoration(
          gradient: AppGradients.forPeriod(period),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.glassBorder, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(city.name, style: AppTypography.title),
                    const SizedBox(width: 6),
                    if (city.isCurrentLocation)
                      const Icon(Icons.location_on_outlined,
                          size: 14, color: AppColors.textSecondary),
                  ],
                ),
                Text(subtitle, style: AppTypography.secondary),
              ],
            ),
            const Positioned(
              right: 0,
              top: 0,
              child: WeatherIcon(
                  condition: WeatherCondition.partlyCloudy, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
