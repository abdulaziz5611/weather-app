import 'package:equatable/equatable.dart';

import 'unit_preferences.dart';

class AppSettings extends Equatable {
  final TempUnit tempUnit;
  final WindUnit windUnit;
  final PressureUnit pressureUnit;
  final DistanceUnit distanceUnit;
  final AppThemeMode themeMode;
  final bool dynamicBackgrounds;
  final bool dailyForecastEnabled;
  final bool severeAlertsEnabled;
  final bool rainAlertsEnabled;

  const AppSettings({
    required this.tempUnit,
    required this.windUnit,
    required this.pressureUnit,
    required this.distanceUnit,
    required this.themeMode,
    required this.dynamicBackgrounds,
    required this.dailyForecastEnabled,
    required this.severeAlertsEnabled,
    required this.rainAlertsEnabled,
  });

  static const defaults = AppSettings(
    tempUnit: TempUnit.celsius,
    windUnit: WindUnit.kmh,
    pressureUnit: PressureUnit.hpa,
    distanceUnit: DistanceUnit.km,
    themeMode: AppThemeMode.dark,
    dynamicBackgrounds: true,
    dailyForecastEnabled: true,
    severeAlertsEnabled: true,
    rainAlertsEnabled: false,
  );

  AppSettings copyWith({
    TempUnit? tempUnit,
    WindUnit? windUnit,
    PressureUnit? pressureUnit,
    DistanceUnit? distanceUnit,
    AppThemeMode? themeMode,
    bool? dynamicBackgrounds,
    bool? dailyForecastEnabled,
    bool? severeAlertsEnabled,
    bool? rainAlertsEnabled,
  }) {
    return AppSettings(
      tempUnit: tempUnit ?? this.tempUnit,
      windUnit: windUnit ?? this.windUnit,
      pressureUnit: pressureUnit ?? this.pressureUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      themeMode: themeMode ?? this.themeMode,
      dynamicBackgrounds: dynamicBackgrounds ?? this.dynamicBackgrounds,
      dailyForecastEnabled: dailyForecastEnabled ?? this.dailyForecastEnabled,
      severeAlertsEnabled: severeAlertsEnabled ?? this.severeAlertsEnabled,
      rainAlertsEnabled: rainAlertsEnabled ?? this.rainAlertsEnabled,
    );
  }

  @override
  List<Object?> get props => [
        tempUnit,
        windUnit,
        pressureUnit,
        distanceUnit,
        themeMode,
        dynamicBackgrounds,
        dailyForecastEnabled,
        severeAlertsEnabled,
        rainAlertsEnabled,
      ];
}
