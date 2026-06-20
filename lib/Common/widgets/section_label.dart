import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final Color? color;

  const SectionLabel({super.key, required this.text, this.padding, this.color});

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.fromLTRB(16, 10, 16, 6),
    child: Text(
      text.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: color ?? AppColors.textSecondary,
      ),
    ),
  );
}
