

import 'package:fifa_2026_live_score_update/App/models/stadium_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final StadiumModel stadium;
  final bool isFirst;

  const VenueCard({super.key, required this.stadium, this.isFirst = false});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isFirst ? AppColors.gold.withValues(alpha: 0.4) : AppColors.border,
        width: isFirst ? 1.5 : 1,
      ),
    ),
    child: Row(
      children: [
        _icon(),
        const SizedBox(width: 14),
        Expanded(child: _info()),
        _capacity(),
      ],
    ),
  );

  Widget _icon() => Container(
    width: 44, height: 44,
    decoration: BoxDecoration(
      color: isFirst ? AppColors.goldSurface : AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(Icons.stadium_outlined, color: isFirst ? AppColors.gold : AppColors.textSecondary, size: 22),
  );

  Widget _info() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(stadium.nameEn, style: AppTextStyles.titleSmall, overflow: TextOverflow.ellipsis),
      const SizedBox(height: 2),
      Text('${stadium.cityEn} · ${stadium.countryEn}', style: AppTextStyles.labelMedium, overflow: TextOverflow.ellipsis),
    ],
  );

  Widget _capacity() => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(stadium.formattedCapacity, style: AppTextStyles.titleLarge.copyWith(fontSize: 18)),
      const Text('capacity', style: AppTextStyles.labelSmall),
    ],
  );
}
