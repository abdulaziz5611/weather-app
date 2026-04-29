import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import 'data/datasources/local_data_source/cities_local_data_source.dart';
import 'data/datasources/local_data_source/cities_local_data_source_impl.dart';
import 'data/repositories/cities_repository_impl.dart';
import 'domain/repositories/cities_repository.dart';
import 'domain/usecases/add_city.dart';
import 'domain/usecases/get_active_city.dart';
import 'domain/usecases/get_saved_cities.dart';
import 'domain/usecases/remove_city.dart';
import 'domain/usecases/reorder_cities.dart';
import 'domain/usecases/set_active_city.dart';
import 'presentation/cubit/active_location_cubit.dart';
import 'presentation/cubit/cities_cubit.dart';

Future<void> initCitiesDi(GetIt sl) async {
  final box = await Hive.openBox<String>(AppConstants.citiesBox);

  sl.registerLazySingleton(
    () => CitiesCubit(
      getSavedCities: sl(),
      addCity: sl(),
      removeCity: sl(),
      reorderCities: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ActiveLocationCubit(
      getActiveCity: sl(),
      setActiveCity: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetSavedCities(sl()));
  sl.registerLazySingleton(() => AddCity(sl()));
  sl.registerLazySingleton(() => RemoveCity(sl()));
  sl.registerLazySingleton(() => ReorderCities(sl()));
  sl.registerLazySingleton(() => GetActiveCity(sl()));
  sl.registerLazySingleton(() => SetActiveCity(sl()));

  sl.registerLazySingleton<CitiesRepository>(
    () => CitiesRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<CitiesLocalDataSource>(
    () => CitiesLocalDataSourceImpl(box),
  );
}
