import 'package:fifa_2026_live_score_update/App/home/match_controller.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_card.dart';
import 'package:fifa_2026_live_score_update/App/home/widgets/match_card_shimmer.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/error_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/filter_pill.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/section_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixturesPage extends ConsumerWidget {
  const FixturesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchProvider);

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Fixtures',
        // actions: [
        //   AppIconButton(icon: Icons.filter_list_outlined, onTap: () {}),
        // ],
      ),
      body: Builder(
        builder: (_) {
          if (state.isLoading && state.matches.isEmpty) {
            return const MatchCardShimmer(count: 5);
          }
          if (state.error != null && state.matches.isEmpty) {
            return ErrorStateWidget(
              icon: Icons.cloud_off_outlined,
              title: 'Something Went Wrong',
              message: 'Our servers are having trouble. Please try later.',
              retryLabel: 'Reload',
              onRetry: () => ref.read(matchProvider.notifier).fetch(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _fixtureDatePills(),
              const SizedBox(height: 8),
              Expanded(child: _fixtureList()),
            ],
          );
        },
      ),
    );
  }

  // Date pills

  Widget _fixtureDatePills() {
    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(matchProvider.notifier);
        final dates = notifier.fixtureDates();
        final selectedDate = ref.watch(
          matchProvider.select((s) => s.selectedDate),
        );

        if (dates.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: dates.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final d = dates[i];

              return FilterPill(
                label: notifier.tabLabel(d),
                isActive: selectedDate == d,
                onTap: () => ref.read(matchProvider.notifier).setDate(d),
              );
            },
          ),
        );
      },
    );
  }

  // Fixture list

  Widget _fixtureList() {
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(matchProvider.select((s) => s.selectedDate));

        final notifier = ref.read(matchProvider.notifier);
        final matches = notifier.matchesForDate();

        if (matches.isEmpty) {
          return const EmptyStateWidget(
            message: 'No matches on this date',
            icon: Icons.calendar_today_outlined,
          );
        }

        final grouped = notifier.groupByGroup(matches);

        return RefreshIndicator(
          onRefresh: () => ref.read(matchProvider.notifier).fetch(),
          color: AppColors.gold,
          backgroundColor: AppColors.surface,
          child: ListView.builder(
            itemCount: grouped.length,
            itemBuilder: (_, i) {
              final entry = grouped.entries.elementAt(i);

              final sectionTitle = entry.key.length == 1
                  ? 'Group ${entry.key}'
                  : entry.key;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionLabel(text: sectionTitle),
                  ...entry.value.map((m) => MatchCard(match: m)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
