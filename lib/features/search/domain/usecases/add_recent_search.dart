import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city_search_result.dart';
import '../repositories/search_repository.dart';

class AddRecentSearch extends UseCase<void, CitySearchResult> {
  final SearchRepository repository;

  AddRecentSearch(this.repository);

  @override
  Future<Either<Failure, void>> call(CitySearchResult params) {
    return repository.addRecentSearch(params);
  }
}
