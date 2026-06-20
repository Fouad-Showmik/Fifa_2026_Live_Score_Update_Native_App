import 'package:fifa_2026_live_score_update/App/group/group_controller.dart';
import 'package:fifa_2026_live_score_update/App/group/widgets/group_standing_table.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_icon_button.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/empty_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/error_state_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/loading_widget.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/pills_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupsPage extends ConsumerWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Groups',
        actions: [AppIconButton(icon: Icons.tune_outlined, onTap: () {})],
      ),
      body: Builder(
        builder: (_) {
          if (state.isLoading && state.groups.isEmpty) {
            return const LoadingWidget();
          }
          if (state.error != null && state.groups.isEmpty) {
            return ErrorStateWidget(
              message: state.error!,
              onRetry: () => ref.read(groupProvider.notifier).fetch(),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 4),
              PillsRow(
                labels: state.groupNames.map((n) => 'Group $n').toList(),
                activeLabel: 'Group ${state.selectedGroup}',
                onSelected: (lbl) => ref
                    .read(groupProvider.notifier)
                    .selectGroup(lbl.replaceFirst('Group ', '')),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Builder(
                  builder: (_) {
                    final group = state.currentGroup;
                    if (group == null) {
                      return const EmptyStateWidget(message: 'No group data');
                    }
                    return RefreshIndicator(
                      onRefresh: () => ref.read(groupProvider.notifier).fetch(),
                      color: AppColors.gold,
                      backgroundColor: AppColors.surface,
                      child: ListView(
                        children: [
                          GroupStandingTable(group: group),
                          const SizedBox(height: 12),
                          _qualNote(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _qualNote() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.finished,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Qualified for Round of 32',
            style: AppTextStyles.labelMedium,
          ),
        ],
      ),
    );
  }
}
