import '../../models/weather_forecast_model.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheForecast(WeatherForecastModel forecast);
  Future<WeatherForecastModel?> getCachedForecast();
}
