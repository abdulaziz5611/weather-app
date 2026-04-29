import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/cities/cities_injection_container.dart';
import '../../features/onboarding/onboarding_injection_container.dart';
import '../../features/search/search_injection_container.dart';
import '../../features/settings/settings_injection_container.dart';
import '../../features/weather/weather_injection_container.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../services/location_service.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());

  await initOnboardingDi(sl);
  await initWeatherDi(sl);
  await initCitiesDi(sl);
  await initSearchDi(sl);
  await initSettingsDi(sl);
}
