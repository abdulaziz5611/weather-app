import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/cities_repository.dart';

class RemoveCity extends UseCase<void, String> {
  final CitiesRepository repository;

  RemoveCity(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.removeCity(params);
  }
}
