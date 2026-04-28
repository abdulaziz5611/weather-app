import 'package:get_it/get_it.dart';

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
  sl.registerLazySingleton(
    () => WeatherCubit(getWeatherForecast: sl(), getAirQuality: sl()),
  );

  sl.registerLazySingleton(() => GetWeatherForecast(sl()));
  sl.registerLazySingleton(() => GetAirQuality(sl()));

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(),
  );
}
