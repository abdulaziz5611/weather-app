import '../../models/weather_forecast_model.dart';
import 'weather_local_data_source.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  @override
  Future<void> cacheForecast(WeatherForecastModel forecast) async {}

  @override
  Future<WeatherForecastModel?> getCachedForecast() async => null;
}
