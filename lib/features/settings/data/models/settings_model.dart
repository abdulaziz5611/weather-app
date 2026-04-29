import '../../domain/entities/app_settings.dart';
import '../../domain/entities/unit_preferences.dart';

class SettingsModel extends AppSettings {
  const SettingsModel({
    required super.tempUnit,
    required super.windUnit,
    required super.pressureUnit,
    required super.distanceUnit,
    required super.themeMode,
    required super.dynamicBackgrounds,
    required super.dailyForecastEnabled,
    required super.severeAlertsEnabled,
    required super.rainAlertsEnabled,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      tempUnit: TempUnit.values[json['tempUnit'] as int? ?? 0],
      windUnit: WindUnit.values[json['windUnit'] as int? ?? 0],
      pressureUnit: PressureUnit.values[json['pressureUnit'] as int? ?? 0],
      distanceUnit: DistanceUnit.values[json['distanceUnit'] as int? ?? 0],
      themeMode: AppThemeMode.values[json['themeMode'] as int? ?? 1],
      dynamicBackgrounds: json['dynamicBackgrounds'] as bool? ?? true,
      dailyForecastEnabled: json['dailyForecastEnabled'] as bool? ?? true,
      severeAlertsEnabled: json['severeAlertsEnabled'] as bool? ?? true,
      rainAlertsEnabled: json['rainAlertsEnabled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'tempUnit': tempUnit.index,
        'windUnit': windUnit.index,
        'pressureUnit': pressureUnit.index,
        'distanceUnit': distanceUnit.index,
        'themeMode': themeMode.index,
        'dynamicBackgrounds': dynamicBackgrounds,
        'dailyForecastEnabled': dailyForecastEnabled,
        'severeAlertsEnabled': severeAlertsEnabled,
        'rainAlertsEnabled': rainAlertsEnabled,
      };

  factory SettingsModel.fromAppSettings(AppSettings s) {
    return SettingsModel(
      tempUnit: s.tempUnit,
      windUnit: s.windUnit,
      pressureUnit: s.pressureUnit,
      distanceUnit: s.distanceUnit,
      themeMode: s.themeMode,
      dynamicBackgrounds: s.dynamicBackgrounds,
      dailyForecastEnabled: s.dailyForecastEnabled,
      severeAlertsEnabled: s.severeAlertsEnabled,
      rainAlertsEnabled: s.rainAlertsEnabled,
    );
  }
}
