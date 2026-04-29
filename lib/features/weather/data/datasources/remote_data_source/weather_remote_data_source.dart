import '../../../../../core/utils/coordinates.dart';

abstract class WeatherRemoteDataSource {
  Future<Map<String, dynamic>> fetchForecast(Coordinates coords);
  Future<Map<String, dynamic>> fetchAirQuality(Coordinates coords);
}
