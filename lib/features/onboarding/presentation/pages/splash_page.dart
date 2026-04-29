import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../../domain/usecases/check_first_run.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _decideRoute();
  }

  Future<void> _decideRoute() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final result = await sl<CheckFirstRun>()(const NoParams());
    if (!mounted) return;
    final isFirstRun = result.fold((_) => true, (v) => v);
    Navigator.of(context).pushReplacementNamed(
      isFirstRun ? RouteNames.welcome : RouteNames.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        period: TimeOfDayPeriod.morning,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WeatherIcon(
                condition: WeatherCondition.partlyCloudy,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text('SkyCast', style: AppTypography.titleLarge),
              const SizedBox(height: 8),
              Text('Weather, quietly in the air.', style: AppTypography.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
