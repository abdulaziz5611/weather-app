import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
