import '../../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel?> getSettings();
  Future<void> saveSettings(SettingsModel settings);
}
