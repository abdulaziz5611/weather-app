import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import 'data/datasources/local_data_source/onboarding_local_data_source.dart';
import 'data/datasources/local_data_source/onboarding_local_data_source_impl.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/usecases/check_first_run.dart';
import 'domain/usecases/complete_onboarding.dart';
import 'presentation/cubit/onboarding_cubit.dart';

Future<void> initOnboardingDi(GetIt sl) async {
  final box = await Hive.openBox<bool>(AppConstants.onboardingBox);

  sl.registerFactory(
    () => OnboardingCubit(
      locationService: sl(),
      completeOnboarding: sl(),
    ),
  );

  sl.registerLazySingleton(() => CheckFirstRun(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(box),
  );
}
