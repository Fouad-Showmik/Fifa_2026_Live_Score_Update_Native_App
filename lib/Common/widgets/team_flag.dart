import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class TeamFlag extends StatelessWidget {
  final String flagUrl;
  final double size;

  const TeamFlag({super.key, required this.flagUrl, this.size = 26});

  @override
  Widget build(BuildContext context) {
    if (flagUrl.isEmpty) return _placeholder();
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: CachedNetworkImage(
        imageUrl: flagUrl,
        width: size * 1.4,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => Shimmer.fromColors(
          baseColor: AppColors.surface,
          highlightColor: AppColors.surfaceVariant,
          child: _box(),
        ),
        errorWidget: (_, _, _) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Container(
    width: size * 1.4,
    height: size,
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Icon(
      Icons.flag_outlined,
      size: size * 0.55,
      color: AppColors.textMuted,
    ),
  );

  Widget _box() =>
      Container(width: size * 1.4, height: size, color: AppColors.surface);
}
