import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_card.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchList extends ConsumerWidget {
  const MatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(matchProvider);
    final matches = ref.read(matchProvider.notifier).filteredHomeMatches();

    if (matches.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: EmptyStateWidget(message: 'No Matches Found'),
      );
    }
    return Column(children: matches.map((m) => MatchCard(match: m)).toList());
  }
}