import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/utils/coordinates.dart';
import '../../models/air_quality_model.dart';
import '../../models/weather_forecast_model.dart';
import 'weather_remote_data_source.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherForecastModel> fetchForecast(Coordinates coords) async {
    try {
      final response = await dio.get(
        '${ApiConstants.openMeteoBaseUrl}/forecast',
        queryParameters: {
          'latitude': coords.latitude,
          'longitude': coords.longitude,
          'current':
              'temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,wind_speed_10m,wind_direction_10m,pressure_msl',
          'hourly': 'temperature_2m,precipitation_probability,weather_code',
          'daily':
              'weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum',
          'timezone': 'auto',
          'forecast_days': 10,
        },
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return WeatherForecastModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw const ServerException();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }

  @override
  Future<AirQualityModel> fetchAirQuality(Coordinates coords) async {
    try {
      final response = await dio.get(
        '${ApiConstants.openMeteoAirQualityUrl}/air-quality',
        queryParameters: {
          'latitude': coords.latitude,
          'longitude': coords.longitude,
          'current': 'european_aqi,pm2_5,pm10,ozone,nitrogen_dioxide',
        },
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return AirQualityModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw const ServerException();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
