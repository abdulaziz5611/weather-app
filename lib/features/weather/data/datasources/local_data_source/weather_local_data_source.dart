import '../../../../../core/utils/coordinates.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheForecast(Coordinates coords, Map<String, dynamic> json);
  Future<Map<String, dynamic>?> getCachedForecast(Coordinates coords);
  Future<void> cacheAirQuality(Coordinates coords, Map<String, dynamic> json);
  Future<Map<String, dynamic>?> getCachedAirQuality(Coordinates coords);
}
