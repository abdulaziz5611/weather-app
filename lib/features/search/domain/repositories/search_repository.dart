import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/city_search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<CitySearchResult>>> searchCities(String query);
  Future<Either<Failure, List<CitySearchResult>>> getRecentSearches();
  Future<Either<Failure, void>> addRecentSearch(CitySearchResult city);
  Future<Either<Failure, void>> clearRecentSearches();
}
