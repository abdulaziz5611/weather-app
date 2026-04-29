import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city_search_result.dart';
import '../repositories/search_repository.dart';

class GetRecentSearches extends UseCase<List<CitySearchResult>, NoParams> {
  final SearchRepository repository;

  GetRecentSearches(this.repository);

  @override
  Future<Either<Failure, List<CitySearchResult>>> call(NoParams params) {
    return repository.getRecentSearches();
  }
}
