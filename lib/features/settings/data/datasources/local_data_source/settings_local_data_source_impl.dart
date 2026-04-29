import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../models/settings_model.dart';
import 'settings_local_data_source.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Box<String> box;

  SettingsLocalDataSourceImpl(this.box);

  @override
  Future<SettingsModel?> getSettings() async {
    final raw = box.get(AppConstants.settingsKey);
    if (raw == null || raw.isEmpty) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return SettingsModel.fromJson(json);
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    await box.put(AppConstants.settingsKey, jsonEncode(settings.toJson()));
  }
}
