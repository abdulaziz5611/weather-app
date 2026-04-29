import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/search_repository.dart';

class ClearRecentSearches extends UseCase<void, NoParams> {
  final SearchRepository repository;

  ClearRecentSearches(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.clearRecentSearches();
  }
}
