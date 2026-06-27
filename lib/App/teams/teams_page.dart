import 'package:fifa_2026_live_score_update/App/group/group_controller.dart';
import 'package:fifa_2026_live_score_update/App/teams/team_controller.dart';
import 'package:fifa_2026_live_score_update/App/teams/widgets/team_list_card.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/error_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/loading_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/pills_row.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/section_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamsPage extends ConsumerWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Scaffold(
      appBar: const AppTopBar(showLogo: false, title: 'Teams'),
      body: Builder(
        builder: (_) {
          if (teamState.isLoading && teamState.teams.isEmpty) {
            return const LoadingWidget();
          }
          if (teamState.error != null && teamState.teams.isEmpty) {
            return ErrorStateWidget(
              icon: Icons.cloud_off_outlined,
              title: 'Something Went Wrong',
              message: 'Our servers are having trouble. Please try later.',
              retryLabel: 'Reload',
              onRetry: () => ref.read(teamProvider.notifier).fetch(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel(
                text: 'By Group',
                padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
              ),
              PillsRow(
                labels: teamState.groupFilters,
                activeLabel: teamState.selectedGroup,
                onSelected: (g) =>
                    ref.read(teamProvider.notifier).selectGroup(g),
              ),
              const SizedBox(height: 12),
              Expanded(child: _teamList(teamState: teamState)),
            ],
          );
        },
      ),
    );
  }

  Widget _teamList({required TeamState teamState}) {
    return Consumer(
      builder: (context, ref, child) {
        final groupState = ref.watch(groupProvider);
        final byGroup = teamState.teamsByGroup;

        if (byGroup.isEmpty) {
          return const EmptyStateWidget(message: 'No teams found');
        }

        return RefreshIndicator(
          onRefresh: () => ref.read(teamProvider.notifier).fetch(),
          color: AppColors.gold,
          backgroundColor: AppColors.surface,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: byGroup.length,
            itemBuilder: (_, i) {
              final entry = byGroup.entries.elementAt(i);
              final gName = entry.key;

              final gModel = groupState.groups
                  .where((g) => g.name == gName)
                  .firstOrNull;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionLabel(
                    text: 'Group $gName',
                    color: AppColors.gold,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                  ),
                  TeamListCard(teams: entry.value, standings: gModel?.teams),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
