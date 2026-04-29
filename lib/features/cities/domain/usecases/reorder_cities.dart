import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/saved_city.dart';
import '../repositories/cities_repository.dart';

class ReorderCities extends UseCase<void, List<SavedCity>> {
  final CitiesRepository repository;

  ReorderCities(this.repository);

  @override
  Future<Either<Failure, void>> call(List<SavedCity> params) {
    return repository.reorderCities(params);
  }
}
