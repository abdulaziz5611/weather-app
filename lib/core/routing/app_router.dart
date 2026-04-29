import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cities/presentation/cubit/cities_cubit.dart';
import '../../features/cities/presentation/pages/my_cities_page.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/onboarding/presentation/pages/location_permission_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';
import '../../features/weather/presentation/pages/details_page.dart';
import '../../features/weather/presentation/pages/home_page.dart';
import '../di/service_locator.dart';
import '../theme/app_typography.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.welcome:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnboardingCubit>(
            create: (_) => sl<OnboardingCubit>(),
            child: const WelcomePage(),
          ),
        );
      case RouteNames.locationPermission:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnboardingCubit>(
            create: (_) => sl<OnboardingCubit>(),
            child: const LocationPermissionPage(),
          ),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<WeatherCubit>.value(
            value: sl<WeatherCubit>(),
            child: const HomePage(),
          ),
        );
      case RouteNames.details:
        final dayIndex = (settings.arguments as int?) ?? 0;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<WeatherCubit>.value(
            value: sl<WeatherCubit>(),
            child: DetailsPage(selectedDayIndex: dayIndex),
          ),
        );
      case RouteNames.cities:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CitiesCubit>.value(
            value: sl<CitiesCubit>(),
            child: const MyCitiesPage(),
          ),
        );
      case RouteNames.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SearchCubit>(
            create: (_) => sl<SearchCubit>(),
            child: const SearchPage(),
          ),
        );
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Route ${settings.name} — coming soon',
                style: AppTypography.body,
              ),
            ),
          ),
        );
    }
  }
}
