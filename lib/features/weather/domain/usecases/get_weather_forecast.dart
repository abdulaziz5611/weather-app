import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/coordinates.dart';
import '../entities/weather_forecast.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast extends UseCase<WeatherForecast, Coordinates> {
  final WeatherRepository repository;

  GetWeatherForecast(this.repository);

  @override
  Future<Either<Failure, WeatherForecast>> call(Coordinates params) {
    return repository.getWeatherForecast(params);
  }
}
