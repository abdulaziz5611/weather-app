import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import 'data/datasources/local_data_source/search_local_data_source.dart';
import 'data/datasources/local_data_source/search_local_data_source_impl.dart';
import 'data/datasources/remote_data_source/search_remote_data_source.dart';
import 'data/datasources/remote_data_source/search_remote_data_source_impl.dart';
import 'data/repositories/search_repository_impl.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/usecases/add_recent_search.dart';
import 'domain/usecases/clear_recent_searches.dart';
import 'domain/usecases/get_recent_searches.dart';
import 'domain/usecases/search_cities.dart';
import 'presentation/cubit/search_cubit.dart';

Future<void> initSearchDi(GetIt sl) async {
  final box = await Hive.openBox<String>(AppConstants.recentSearchesBox);

  sl.registerFactory(
    () => SearchCubit(
      searchCities: sl(),
      getRecentSearches: sl(),
      addRecentSearch: sl(),
      clearRecentSearches: sl(),
    ),
  );

  sl.registerLazySingleton(() => SearchCities(sl()));
  sl.registerLazySingleton(() => GetRecentSearches(sl()));
  sl.registerLazySingleton(() => AddRecentSearch(sl()));
  sl.registerLazySingleton(() => ClearRecentSearches(sl()));

  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(box),
  );
}
