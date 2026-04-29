import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/routing/route_names.dart';
import 'core/theme/app_theme.dart';
import 'features/cities/presentation/cubit/active_location_cubit.dart';

class SkyCastApp extends StatelessWidget {
  const SkyCastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveLocationCubit>.value(
      value: sl<ActiveLocationCubit>(),
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        initialRoute: RouteNames.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
