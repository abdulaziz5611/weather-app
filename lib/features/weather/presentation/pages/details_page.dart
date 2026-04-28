import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/types/weather_condition.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/hourly_forecast.dart';
import '../../domain/entities/weather_forecast.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/air_quality_card.dart';
import '../widgets/precipitation_bars.dart';
import '../widgets/sun_moon_card.dart';
import '../widgets/temperature_chart.dart';
import '../widgets/wind_compass.dart';

class DetailsPage extends StatelessWidget {
  final int selectedDayIndex;

  const DetailsPage({super.key, required this.selectedDayIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return GradientBackground(
            child: SafeArea(
              child: switch (state) {
                WeatherLoaded(:final forecast, :final airQuality) => _LoadedView(
                    forecast: forecast,
                    airQuality: airQuality,
                    dayIndex: selectedDayIndex,
                  ),
                WeatherError(:final message) => _ErrorView(message: message),
                _ => const Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
              },
            ),
          );
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final WeatherForecast forecast;
  final dynamic airQuality;
  final int dayIndex;

  const _LoadedView({
    required this.forecast,
    required this.airQuality,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context) {
    final day = forecast.daily[dayIndex];
    final hours = _hourlyForDate(forecast.hourly, day.date);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(label: _dayLabel(dayIndex, day.date)),
          const SizedBox(height: 12),
          _Hero(day: day),
          const SizedBox(height: 16),
          TemperatureChart(hours: hours),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: PrecipitationCard(day: day, hours: hours)),
                const SizedBox(width: 12),
                Expanded(
                  child: WindCompassCard(
                    speedKmh: forecast.current.windSpeed,
                    directionDegrees: forecast.current.windDirection,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (airQuality != null) AirQualityCard(airQuality: airQuality),
          if (airQuality != null) const SizedBox(height: 12),
          SunMoonCard(sunrise: day.sunrise, sunset: day.sunset),
        ],
      ),
    );
  }

  List<HourlyForecast> _hourlyForDate(List<HourlyForecast> all, DateTime date) {
    return all.where((h) {
      return h.time.year == date.year &&
          h.time.month == date.month &&
          h.time.day == date.day;
    }).toList();
  }

  String _dayLabel(int index, DateTime date) {
    if (index == 0) return 'Today';
    const names = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return names[date.weekday - 1];
  }
}

class _TopBar extends StatelessWidget {
  final String label;
  const _TopBar({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.chevron_left_rounded,
                    size: 22, color: AppColors.textPrimary),
                Text('Porto', style: AppTypography.body),
              ],
            ),
          ),
        ),
        const Spacer(),
        Text(label, style: AppTypography.title),
        const Spacer(),
        const SizedBox(width: 60),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  final DailyForecast day;
  const _Hero({required this.day});

  @override
  Widget build(BuildContext context) {
    final summary = day.precipitationSum > 1
        ? 'Rain showers · ${day.precipitationSum.toStringAsFixed(1)} mm expected'
        : '${WeatherConditionMapper.label(day.condition)} day expected';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day.temperatureMax.toTemp(),
                style: AppTypography.display.copyWith(fontSize: 72),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('H ${day.temperatureMax.toTemp()}',
                        style: AppTypography.body),
                    Text('L ${day.temperatureMin.toTemp()}',
                        style: AppTypography.secondary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(summary, style: AppTypography.headline),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Text(message, style: AppTypography.body, textAlign: TextAlign.center),
      ),
    );
  }
}
