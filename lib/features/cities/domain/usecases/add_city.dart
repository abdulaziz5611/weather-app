import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/saved_city.dart';
import '../repositories/cities_repository.dart';

class AddCity extends UseCase<void, SavedCity> {
  final CitiesRepository repository;

  AddCity(this.repository);

  @override
  Future<Either<Failure, void>> call(SavedCity params) {
    return repository.addCity(params);
  }
}
