import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/saved_city.dart';

abstract class CitiesRepository {
  Future<Either<Failure, List<SavedCity>>> getSavedCities();
  Future<Either<Failure, void>> addCity(SavedCity city);
  Future<Either<Failure, void>> removeCity(String cityId);
  Future<Either<Failure, void>> reorderCities(List<SavedCity> cities);

  Future<Either<Failure, SavedCity?>> getActiveCity();
  Future<Either<Failure, void>> setActiveCity(SavedCity city);
}
