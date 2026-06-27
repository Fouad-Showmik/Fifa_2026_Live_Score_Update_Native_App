import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/search_field.dart';
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final List<Widget> actions;
  final bool isSearching;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchClose;

  const AppTopBar({
    super.key,
    this.title,
    this.showLogo = false,
    this.actions = const [],
    this.isSearching = false,
    this.onSearchChanged,
    this.onSearchClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleSpacing: 16,
      title: isSearching ? _searchField() : (showLogo ? _logo() : _title()),
      actions: isSearching ? [] : [...actions, const SizedBox(width: 4)],
    );
  }


  Widget _searchField() => SearchField(
    onChanged: onSearchChanged ?? (_) {},
    onClose: onSearchClose ?? () {},
  );

  // Logo

  Widget _logo() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.emoji_events_rounded, color: AppColors.gold, size: 26),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FIFA WORLD CUP',
            style: AppTextStyles.titleMedium.copyWith(fontSize: 16),
          ),
          Text(
            '2026',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.gold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
  );

  // Title
  Widget _title() =>
      Text((title ?? '').toUpperCase(), style: AppTextStyles.displayMedium);
}
