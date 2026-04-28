import '../../../../../core/utils/coordinates.dart';
import '../../models/air_quality_model.dart';
import '../../models/weather_forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherForecastModel> fetchForecast(Coordinates coords);
  Future<AirQualityModel> fetchAirQuality(Coordinates coords);
}
