import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/saved_city.dart';
import '../../domain/repositories/cities_repository.dart';
import '../datasources/local_data_source/cities_local_data_source.dart';
import '../models/saved_city_model.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesLocalDataSource localDataSource;

  CitiesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<SavedCity>>> getSavedCities() async {
    try {
      final cities = await localDataSource.getCities();
      return Right(cities);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCity(SavedCity city) async {
    try {
      await localDataSource.addCity(SavedCityModel.fromSavedCity(city));
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeCity(String cityId) async {
    try {
      await localDataSource.removeCity(cityId);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> reorderCities(List<SavedCity> cities) async {
    try {
      await localDataSource.setCities(
        cities.map((c) => SavedCityModel.fromSavedCity(c)).toList(),
      );
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SavedCity?>> getActiveCity() async {
    try {
      final city = await localDataSource.getActiveCity();
      return Right(city);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setActiveCity(SavedCity city) async {
    try {
      await localDataSource.setActiveCity(SavedCityModel.fromSavedCity(city));
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }
}
