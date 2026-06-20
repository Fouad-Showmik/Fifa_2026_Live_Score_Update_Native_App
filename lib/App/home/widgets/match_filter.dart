
import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/filter_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterRow extends ConsumerWidget {
  const FilterRow({super.key});

  static const _filters = [
    (LiveScoreFilter.all, 'All Matches'),
    (LiveScoreFilter.live, 'Live'),
    (LiveScoreFilter.finished, 'Finished'),
    (LiveScoreFilter.upcoming, 'Upcoming'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(matchProvider.select((s) => s.liveFilter));
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: _filters
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterPill(
                  label: f.$2,
                  isActive: current == f.$1,
                  onTap: () =>
                      ref.read(matchProvider.notifier).setLiveFilter(f.$1),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}