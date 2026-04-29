import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/coordinates.dart';
import '../../domain/entities/air_quality.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/local_data_source/weather_local_data_source.dart';
import '../datasources/remote_data_source/weather_remote_data_source.dart';
import '../models/air_quality_model.dart';
import '../models/weather_forecast_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherForecast(Coordinates coords) async {
    if (await networkInfo.isConnected) {
      try {
        final raw = await remoteDataSource.fetchForecast(coords);
        await localDataSource.cacheForecast(coords, raw);
        return Right(WeatherForecastModel.fromJson(raw));
      } on ServerException catch (e) {
        final cached = await localDataSource.getCachedForecast(coords);
        if (cached != null) return Right(WeatherForecastModel.fromJson(cached));
        return Left(ServerFailure(e.message));
      } catch (_) {
        final cached = await localDataSource.getCachedForecast(coords);
        if (cached != null) return Right(WeatherForecastModel.fromJson(cached));
        return const Left(ServerFailure());
      }
    }
    final cached = await localDataSource.getCachedForecast(coords);
    if (cached != null) return Right(WeatherForecastModel.fromJson(cached));
    return const Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, AirQuality>> getAirQuality(Coordinates coords) async {
    if (await networkInfo.isConnected) {
      try {
        final raw = await remoteDataSource.fetchAirQuality(coords);
        await localDataSource.cacheAirQuality(coords, raw);
        return Right(AirQualityModel.fromJson(raw));
      } on ServerException catch (e) {
        final cached = await localDataSource.getCachedAirQuality(coords);
        if (cached != null) return Right(AirQualityModel.fromJson(cached));
        return Left(ServerFailure(e.message));
      } catch (_) {
        final cached = await localDataSource.getCachedAirQuality(coords);
        if (cached != null) return Right(AirQualityModel.fromJson(cached));
        return const Left(ServerFailure());
      }
    }
    final cached = await localDataSource.getCachedAirQuality(coords);
    if (cached != null) return Right(AirQualityModel.fromJson(cached));
    return const Left(NetworkFailure());
  }
}
