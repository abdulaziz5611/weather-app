import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/unit_preferences.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_settings.dart';

class SettingsCubit extends Cubit<AppSettings> {
  final GetSettings getSettings;
  final UpdateSettings updateSettings;

  SettingsCubit({
    required this.getSettings,
    required this.updateSettings,
  }) : super(AppSettings.defaults) {
    _load();
  }

  Future<void> _load() async {
    final result = await getSettings(const NoParams());
    result.fold((_) {}, emit);
  }

  Future<void> _persist(AppSettings next) async {
    emit(next);
    await updateSettings(next);
  }

  Future<void> setTempUnit(TempUnit u) => _persist(state.copyWith(tempUnit: u));
  Future<void> setWindUnit(WindUnit u) => _persist(state.copyWith(windUnit: u));
  Future<void> setPressureUnit(PressureUnit u) =>
      _persist(state.copyWith(pressureUnit: u));
  Future<void> setDistanceUnit(DistanceUnit u) =>
      _persist(state.copyWith(distanceUnit: u));
  Future<void> setThemeMode(AppThemeMode m) =>
      _persist(state.copyWith(themeMode: m));
  Future<void> setDynamicBackgrounds(bool v) =>
      _persist(state.copyWith(dynamicBackgrounds: v));
  Future<void> setDailyForecastEnabled(bool v) =>
      _persist(state.copyWith(dailyForecastEnabled: v));
  Future<void> setSevereAlertsEnabled(bool v) =>
      _persist(state.copyWith(severeAlertsEnabled: v));
  Future<void> setRainAlertsEnabled(bool v) =>
      _persist(state.copyWith(rainAlertsEnabled: v));
}
