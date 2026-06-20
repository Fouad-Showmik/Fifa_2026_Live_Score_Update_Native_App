//mimics the exact shape of MatchCard so users always see something instead of a blank screen
import 'package:flutter/material.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';
class MatchCardShimmer extends StatelessWidget {
  final int count;
  const MatchCardShimmer({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) => Column(
    children: List.generate(count, (_) =>
      Shimmer.fromColors(
        baseColor: AppColors.surface,
        highlightColor: AppColors.surfaceVariant,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          height: 112,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );
}