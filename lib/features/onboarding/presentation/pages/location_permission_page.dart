import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../cities/presentation/cubit/active_location_cubit.dart';
import '../../../cities/presentation/cubit/cities_cubit.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  Future<void> _finishWithDefault(BuildContext context) async {
    await context.read<OnboardingCubit>().markComplete();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.home,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        period: TimeOfDayPeriod.morning,
        child: SafeArea(
          child: BlocListener<OnboardingCubit, OnboardingState>(
            listener: (context, state) async {
              if (state is OnboardingLocationReady) {
                await context
                    .read<ActiveLocationCubit>()
                    .setActive(state.city);
                if (!context.mounted) return;
                await context.read<CitiesCubit>().add(state.city);
                if (!context.mounted) return;
                await context.read<OnboardingCubit>().markComplete();
                if (!context.mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.home,
                  (_) => false,
                );
              } else if (state is OnboardingLocationDenied) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Location denied — using Porto as the default. You can add cities anytime.',
                      style: AppTypography.secondary,
                    ),
                    backgroundColor: AppColors.surfaceDim,
                  ),
                );
                await _finishWithDefault(context);
              } else if (state is OnboardingError) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message, style: AppTypography.secondary),
                    backgroundColor: AppColors.surfaceDim,
                  ),
                );
              }
            },
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                final isLoading = state is OnboardingRequestingLocation;
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => _finishWithDefault(context),
                            child: Text(
                              'Skip',
                              style: AppTypography.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.glassBorder,
                            width: 1,
                          ),
                          color: AppColors.glassFill,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.textPrimary,
                          size: 40,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Stay local, automatically.',
                        style: AppTypography.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "We'll use your location to show weather for exactly where you are. It's fetched, never stored — not by us, not by anyone.",
                        style: AppTypography.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: isLoading
                              ? null
                              : () => context
                                  .read<OnboardingCubit>()
                                  .requestLocation(),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.textPrimary,
                            foregroundColor: AppColors.background,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.background,
                                  ),
                                )
                              : Text(
                                  'Allow location',
                                  style: AppTypography.body.copyWith(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
