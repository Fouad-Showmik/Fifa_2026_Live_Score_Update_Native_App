import 'package:cached_network_image/cached_network_image.dart';
import 'package:fifa_2026_live_score_update/App/models/stadium_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final StadiumModel stadium;

  const VenueCard({super.key, required this.stadium});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image(),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(child: _info()),
              _capacity(),
            ],
          ),
        ),
      ],
    ),
  );

  // Stadium image

  Widget _image() => ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
    child: Image.asset(
      stadium.imagePath,
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imageFallback(),
    ),
  );

  Widget _imageFallback() => Container(
    height: 160,
    color: AppColors.surfaceVariant,
    child: const Center(
      child: Icon(
        Icons.stadium_outlined,
        size: 48,
        color: AppColors.textSecondary,
      ),
    ),
  );

  Widget _imagePlaceholder() => Container(
    height: 160,
    color: AppColors.surfaceVariant,
    child: const Center(
      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gold),
    ),
  );

  // Info

  Widget _info() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        stadium.nameEn,
        style: AppTextStyles.titleSmall,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 2),
      Row(
        children: [
          const Icon(
            Icons.place_outlined,
            size: 12,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '${stadium.cityEn} · ${stadium.countryEn}',
              style: AppTextStyles.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ],
  );

  // Capacity

  Widget _capacity() => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        stadium.formattedCapacity,
        style: AppTextStyles.titleLarge.copyWith(fontSize: 18),
      ),
      const Text('capacity', style: AppTextStyles.labelSmall),
    ],
  );
}
