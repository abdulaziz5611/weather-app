import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/weather_forecast.dart';

class CurrentWeatherHeader extends StatelessWidget {
  final WeatherForecast forecast;
  final String locationName;
  final bool isCurrentLocation;

  const CurrentWeatherHeader({
    super.key,
    required this.forecast,
    this.locationName = 'Porto',
    this.isCurrentLocation = false,
  });

  String _relativeTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<SettingsCubit>().state.tempUnit;
    final current = forecast.current;
    final today = forecast.daily.first;
    final updatedLabel = 'Updated ${_relativeTime(current.time)}';
    final subtitle =
        isCurrentLocation ? 'My Location · $updatedLabel' : updatedLabel;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isCurrentLocation) ...[
              const Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(subtitle,
                  style: AppTypography.label,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            locationName,
            style: AppTypography.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(current.temperature.toTemp(unit), style: AppTypography.display),
        const SizedBox(height: 4),
        WeatherIcon(condition: current.condition, size: 40),
        const SizedBox(height: 8),
        Text(WeatherConditionMapper.label(current.condition),
            style: AppTypography.headline),
        Text(
          'H:${today.temperatureMax.toTemp(unit)}  ·  L:${today.temperatureMin.toTemp(unit)}  ·  Feels ${current.feelsLike.toTemp(unit)}',
          style: AppTypography.secondary,
        ),
      ],
    );
  }
}
