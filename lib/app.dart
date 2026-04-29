import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_names.dart';
import 'core/theme/app_theme.dart';
import 'features/cities/presentation/cubit/active_location_cubit.dart';
import 'features/cities/presentation/cubit/cities_cubit.dart';
import 'features/settings/domain/entities/app_settings.dart';
import 'features/settings/domain/entities/unit_preferences.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

class SkyCastApp extends StatelessWidget {
  const SkyCastApp({super.key});

  ThemeMode _themeMode(AppThemeMode m) {
    switch (m) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.auto:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveLocationCubit>.value(value: sl<ActiveLocationCubit>()),
        BlocProvider<CitiesCubit>.value(value: sl<CitiesCubit>()),
        BlocProvider<SettingsCubit>.value(value: sl<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, settings) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeMode(settings.themeMode),
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
