import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/city_search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/local_data_source/search_local_data_source.dart';
import '../datasources/remote_data_source/search_remote_data_source.dart';
import '../models/city_search_result_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CitySearchResult>>> searchCities(String query) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final results = await remoteDataSource.searchCities(query);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CitySearchResult>>> getRecentSearches() async {
    try {
      final list = await localDataSource.getRecents();
      return Right(list);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addRecentSearch(CitySearchResult city) async {
    try {
      final model = CitySearchResultModel(
        id: city.id,
        name: city.name,
        country: city.country,
        admin1: city.admin1,
        latitude: city.latitude,
        longitude: city.longitude,
        timezone: city.timezone,
      );
      await localDataSource.addRecent(model);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    try {
      await localDataSource.clearRecents();
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }
}
