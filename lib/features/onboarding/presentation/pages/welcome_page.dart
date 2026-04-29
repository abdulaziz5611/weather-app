import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/weather_icon.dart';
import '../cubit/onboarding_cubit.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Future<void> _skip(BuildContext context) async {
    await context.read<OnboardingCubit>().markComplete();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        period: TimeOfDayPeriod.morning,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () => _skip(context),
                      child: Text(
                        'Skip',
                        style: AppTypography.body
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const WeatherIcon(
                  condition: WeatherCondition.partlyCloudy,
                  size: 96,
                ),
                const Spacer(),
                Text(
                  'Weather that reads\nthe room.',
                  style: AppTypography.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'SkyCast gives you a quick, honest read on the day — no noise, no clutter.',
                  style: AppTypography.body
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RouteNames.locationPermission),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: AppColors.background,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Get started',
                      style: AppTypography.body
                          .copyWith(color: AppColors.background, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
