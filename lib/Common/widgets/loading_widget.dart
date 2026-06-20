import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2.5),
  );
}
