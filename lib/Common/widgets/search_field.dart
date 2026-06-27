import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;

  const SearchField({
    super.key,
    required this.onChanged,
    required this.onClose,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: true,
      style: AppTextStyles.titleSmall.copyWith(fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Search team...',
        hintStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        suffixIcon: Align(
          widthFactor: 1.0,
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              _controller.clear();
              widget.onChanged('');
              widget.onClose();
            },
            child: const Icon(
              Icons.close,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
