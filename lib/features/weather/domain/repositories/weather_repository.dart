import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/coordinates.dart';
import '../entities/air_quality.dart';
import '../entities/weather_forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherForecast>> getWeatherForecast(Coordinates coords);
  Future<Either<Failure, AirQuality>> getAirQuality(Coordinates coords);
}
