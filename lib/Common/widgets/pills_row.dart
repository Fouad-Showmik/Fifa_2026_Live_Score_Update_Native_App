import 'package:fifa_2026_live_score_update/Common/widgets/filter_pill.dart';
import 'package:flutter/material.dart';

class PillsRow extends StatelessWidget {
  final List<String> labels;
  final String activeLabel;
  final ValueChanged<String> onSelected;

  const PillsRow({
    super.key,
    required this.labels,
    required this.activeLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: labels.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (_, i) => FilterPill(
        label: labels[i],
        isActive: labels[i] == activeLabel,
        onTap: () => onSelected(labels[i]),
      ),
    ),
  );
}
