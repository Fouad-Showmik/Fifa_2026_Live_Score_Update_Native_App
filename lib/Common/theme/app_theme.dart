import 'package:flutter/material.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.gold,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.surface,
      onPrimary: AppColors.navBackground,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.displayMedium,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 0,
    ),
    textTheme: const TextTheme(
      displayLarge:  AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      titleLarge:    AppTextStyles.titleLarge,
      titleMedium:   AppTextStyles.titleMedium,
      titleSmall:    AppTextStyles.titleSmall,
      bodyLarge:     AppTextStyles.bodyLarge,
      bodyMedium:    AppTextStyles.bodyMedium,
      labelLarge:    AppTextStyles.labelLarge,
      labelMedium:   AppTextStyles.labelMedium,
      labelSmall:    AppTextStyles.labelSmall,
    ),
  );
}
