import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/saved_city.dart';
import '../repositories/cities_repository.dart';

class GetActiveCity extends UseCase<SavedCity?, NoParams> {
  final CitiesRepository repository;

  GetActiveCity(this.repository);

  @override
  Future<Either<Failure, SavedCity?>> call(NoParams params) {
    return repository.getActiveCity();
  }
}
