import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.background,
        primary: AppColors.accentInfo,
        secondary: AppColors.accentWarn,
        error: AppColors.accentDanger,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display,
        headlineLarge: AppTypography.titleLarge,
        titleLarge: AppTypography.title,
        titleMedium: AppTypography.headline,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.secondary,
        labelSmall: AppTypography.label,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF7F8FB),
      colorScheme: const ColorScheme.light(
        surface: Color(0xFFFFFFFF),
        primary: AppColors.accentInfo,
        secondary: AppColors.accentWarn,
        error: AppColors.accentDanger,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.display.copyWith(color: Colors.black),
        headlineLarge: AppTypography.titleLarge.copyWith(color: Colors.black),
        titleLarge: AppTypography.title.copyWith(color: Colors.black),
        titleMedium: AppTypography.headline.copyWith(color: Colors.black),
        bodyLarge: AppTypography.body.copyWith(color: Colors.black),
        bodyMedium: AppTypography.secondary.copyWith(color: Colors.black54),
        labelSmall: AppTypography.label.copyWith(color: Colors.black54),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
