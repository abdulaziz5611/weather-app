import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import 'data/datasources/local_data_source/settings_local_data_source.dart';
import 'data/datasources/local_data_source/settings_local_data_source_impl.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/update_settings.dart';
import 'presentation/cubit/settings_cubit.dart';

Future<void> initSettingsDi(GetIt sl) async {
  final box = await Hive.openBox<String>(AppConstants.settingsBox);

  sl.registerLazySingleton(
    () => SettingsCubit(getSettings: sl(), updateSettings: sl()),
  );

  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => UpdateSettings(sl()));

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(box),
  );
}
