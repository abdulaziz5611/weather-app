import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../../core/utils/coordinates.dart';
import 'weather_local_data_source.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final Box<String> box;

  WeatherLocalDataSourceImpl(this.box);

  String _forecastKey(Coordinates c) =>
      'f_${c.latitude.toStringAsFixed(4)}_${c.longitude.toStringAsFixed(4)}';

  String _aqKey(Coordinates c) =>
      'a_${c.latitude.toStringAsFixed(4)}_${c.longitude.toStringAsFixed(4)}';

  @override
  Future<void> cacheForecast(Coordinates coords, Map<String, dynamic> json) async {
    await box.put(_forecastKey(coords), jsonEncode(json));
  }

  @override
  Future<Map<String, dynamic>?> getCachedForecast(Coordinates coords) async {
    final raw = box.get(_forecastKey(coords));
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  @override
  Future<void> cacheAirQuality(Coordinates coords, Map<String, dynamic> json) async {
    await box.put(_aqKey(coords), jsonEncode(json));
  }

  @override
  Future<Map<String, dynamic>?> getCachedAirQuality(Coordinates coords) async {
    final raw = box.get(_aqKey(coords));
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
