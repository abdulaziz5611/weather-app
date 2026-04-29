import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import 'data/datasources/local_data_source/weather_local_data_source.dart';
import 'data/datasources/local_data_source/weather_local_data_source_impl.dart';
import 'data/datasources/remote_data_source/weather_remote_data_source.dart';
import 'data/datasources/remote_data_source/weather_remote_data_source_impl.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_air_quality.dart';
import 'domain/usecases/get_weather_forecast.dart';
import 'presentation/cubit/weather_cubit.dart';

Future<void> initWeatherDi(GetIt sl) async {
  final cacheBox = await Hive.openBox<String>(AppConstants.weatherCacheBox);

  sl.registerLazySingleton(
    () => WeatherCubit(getWeatherForecast: sl(), getAirQuality: sl()),
  );

  sl.registerLazySingleton(() => GetWeatherForecast(sl()));
  sl.registerLazySingleton(() => GetAirQuality(sl()));

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(cacheBox),
  );
}
