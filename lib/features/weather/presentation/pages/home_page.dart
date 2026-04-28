import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/utils/coordinates.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/entities/weather_forecast.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/current_weather_header.dart';
import '../widgets/daily_forecast_list.dart';
import '../widgets/hourly_forecast_strip.dart';
import '../widgets/weather_summary_card.dart';

const _defaultCoords = Coordinates.porto;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().loadForecast(_defaultCoords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return GradientBackground(
            child: SafeArea(
              child: switch (state) {
                WeatherInitial() || WeatherLoading() => const _LoadingView(),
                WeatherError(:final message) => _ErrorView(message: message),
                WeatherLoaded(:final forecast) => _LoadedView(forecast: forecast),
              },
            ),
          );
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textPrimary),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(message, style: AppTypography.body, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.read<WeatherCubit>().loadForecast(_defaultCoords),
              child: Text('Retry', style: AppTypography.body),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final WeatherForecast forecast;

  const _LoadedView({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.textPrimary,
      backgroundColor: AppColors.background,
      onRefresh: () => context.read<WeatherCubit>().loadForecast(_defaultCoords),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          children: [
            CurrentWeatherHeader(forecast: forecast),
            const SizedBox(height: 24),
            WeatherSummaryCard(forecast: forecast),
            const SizedBox(height: 14),
            HourlyForecastStrip(hourly: forecast.hourly),
            const SizedBox(height: 14),
            DailyForecastList(
              daily: forecast.daily,
              onDayTap: (i) => Navigator.of(context).pushNamed(
                RouteNames.details,
                arguments: i,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
