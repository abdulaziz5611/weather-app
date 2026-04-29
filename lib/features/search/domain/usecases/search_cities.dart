import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city_search_result.dart';
import '../repositories/search_repository.dart';

class SearchCities extends UseCase<List<CitySearchResult>, String> {
  final SearchRepository repository;

  SearchCities(this.repository);

  @override
  Future<Either<Failure, List<CitySearchResult>>> call(String params) {
    if (params.trim().isEmpty) {
      return Future.value(const Right([]));
    }
    return repository.searchCities(params);
  }
}
