import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/glass_decoration.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/unit_preferences.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/theme_selector.dart';
import '../widgets/unit_segmented_control.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        period: TimeOfDayPeriod.night,
        child: SafeArea(
          child: BlocBuilder<SettingsCubit, AppSettings>(
            builder: (context, settings) {
              final cubit = context.read<SettingsCubit>();
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left_rounded,
                              color: AppColors.textPrimary, size: 28),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Settings', style: AppTypography.titleLarge),
                    const SizedBox(height: 24),
                    _SectionLabel('UNITS'),
                    const SizedBox(height: 8),
                    _SectionCard(
                      children: [
                        _Row(
                          label: 'Temperature',
                          control: UnitSegmentedControl<TempUnit>(
                            options: TempUnit.values,
                            labels: const ['C', 'F'],
                            selected: settings.tempUnit,
                            onChanged: cubit.setTempUnit,
                          ),
                        ),
                        const _Divider(),
                        _Row(
                          label: 'Wind speed',
                          control: UnitSegmentedControl<WindUnit>(
                            options: WindUnit.values,
                            labels: const ['km/h', 'mph', 'm/s'],
                            selected: settings.windUnit,
                            onChanged: cubit.setWindUnit,
                          ),
                        ),
                        const _Divider(),
                        _Row(
                          label: 'Pressure',
                          control: UnitSegmentedControl<PressureUnit>(
                            options: PressureUnit.values,
                            labels: const ['hPa', 'inHg'],
                            selected: settings.pressureUnit,
                            onChanged: cubit.setPressureUnit,
                          ),
                        ),
                        const _Divider(),
                        _Row(
                          label: 'Distance',
                          control: UnitSegmentedControl<DistanceUnit>(
                            options: DistanceUnit.values,
                            labels: const ['km', 'mi'],
                            selected: settings.distanceUnit,
                            onChanged: cubit.setDistanceUnit,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _SectionLabel('APPEARANCE'),
                    const SizedBox(height: 8),
                    _SectionCard(
                      children: [
                        _Row(
                          label: 'Theme',
                          control: ThemeSelector(
                            selected: settings.themeMode,
                            onChanged: cubit.setThemeMode,
                          ),
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Dynamic backgrounds',
                          subtitle: 'Gradient shifts with time & weather',
                          value: settings.dynamicBackgrounds,
                          onChanged: cubit.setDynamicBackgrounds,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _SectionLabel('NOTIFICATIONS'),
                    const SizedBox(height: 8),
                    _SectionCard(
                      children: [
                        _SwitchRow(
                          label: 'Daily forecast',
                          subtitle: 'Every day at 7:00 AM',
                          value: settings.dailyForecastEnabled,
                          onChanged: cubit.setDailyForecastEnabled,
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Severe weather alerts',
                          value: settings.severeAlertsEnabled,
                          onChanged: cubit.setSevereAlertsEnabled,
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Rain alerts',
                          value: settings.rainAlertsEnabled,
                          onChanged: cubit.setRainAlertsEnabled,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(text, style: AppTypography.label),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlassDecoration.card(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(children: children),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final Widget control;
  const _Row({required this.label, required this.control});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTypography.body)),
          control,
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.body),
                if (subtitle != null)
                  Text(subtitle!, style: AppTypography.secondary),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.accentWarn,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: AppColors.glassBorder,
    );
  }
}
