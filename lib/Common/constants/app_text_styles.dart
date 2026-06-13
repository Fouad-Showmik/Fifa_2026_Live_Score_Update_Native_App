import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static const String _f = 'BarlowCondensed';

  static const TextStyle displayLarge = TextStyle(fontFamily: _f, fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.08);
  static const TextStyle displayMedium = TextStyle(fontFamily: _f, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.06);
  static const TextStyle titleLarge = TextStyle(fontFamily: _f, fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: 0.05);
  static const TextStyle titleMedium = TextStyle(fontFamily: _f, fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: 0.02);
  static const TextStyle titleSmall = TextStyle(fontFamily: _f, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle bodyLarge = TextStyle(fontFamily: _f, fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle bodyMedium = TextStyle(fontFamily: _f, fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle labelLarge = TextStyle(fontFamily: _f, fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.06);
  static const TextStyle labelMedium = TextStyle(fontFamily: _f, fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.04);
  static const TextStyle labelSmall = TextStyle(fontFamily: _f, fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.08);
  static const TextStyle scoreDisplay = TextStyle(fontFamily: _f, fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary);
  static const TextStyle navLabel = TextStyle(fontFamily: _f, fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.03);
}
