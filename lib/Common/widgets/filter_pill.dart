import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterPill({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.pillActiveBg : AppColors.pillBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          label,
          style: AppTextStyles.titleSmall.copyWith(
            fontSize: 13,
            height: 1.0,
            leadingDistribution: TextLeadingDistribution.even,
            color: isActive
                ? AppColors.pillActiveText
                : AppColors.textSecondary,
          ),
        ),
      ),
    ),
  );
}
