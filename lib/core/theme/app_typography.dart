import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get display => GoogleFonts.interTight(
        fontSize: 96,
        fontWeight: FontWeight.w200,
        letterSpacing: -4,
        height: 1.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleLarge => GoogleFonts.interTight(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get title => GoogleFonts.interTight(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get headline => GoogleFonts.interTight(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.interTight(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get secondary => GoogleFonts.interTight(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get label => GoogleFonts.interTight(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: AppColors.textSecondary,
      );

  static TextStyle get numericLarge => GoogleFonts.jetBrainsMono(
        fontSize: 48,
        fontWeight: FontWeight.w300,
        color: AppColors.textPrimary,
      );

  static TextStyle get numeric => GoogleFonts.jetBrainsMono(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );
}
