import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_card.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchList extends ConsumerWidget {
  const MatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch full state so list rebuilds when filter or matches change
    ref.watch(matchProvider.select((s) => s.liveFilter));
    final matches = ref.read(matchProvider.notifier).filteredHomeMatches();

    if (matches.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: EmptyStateWidget(message: 'No matches for this filter'),
      );
    }
    return Column(children: matches.map((m) => MatchCard(match: m)).toList());
  }
}