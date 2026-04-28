import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/coordinates.dart';
import '../entities/air_quality.dart';
import '../repositories/weather_repository.dart';

class GetAirQuality extends UseCase<AirQuality, Coordinates> {
  final WeatherRepository repository;

  GetAirQuality(this.repository);

  @override
  Future<Either<Failure, AirQuality>> call(Coordinates params) {
    return repository.getAirQuality(params);
  }
}
