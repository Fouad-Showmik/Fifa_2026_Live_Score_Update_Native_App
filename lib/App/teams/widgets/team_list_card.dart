import 'package:fifa_2026_live_score_update/App/models/group_model.dart';
import 'package:fifa_2026_live_score_update/App/models/team_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/team_flag.dart';
import 'package:flutter/material.dart';

class TeamListCard extends StatelessWidget {
  final List<TeamModel> teams;
  final List<TeamStanding>? standings;

  const TeamListCard({super.key, required this.teams, this.standings});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      children: teams
          .asMap()
          .entries
          .map(
            (e) => Column(
              children: [
                _teamRow(
                  team: e.value,
                  standing: standings?.firstWhereOrNull(
                    (s) => s.teamId == e.value.id,
                  ),
                ),
                if (e.key < teams.length - 1)
                  const Divider(height: 1, color: AppColors.border),
              ],
            ),
          )
          .toList(),
    ),
  );

  Widget _teamRow({required TeamModel team, required TeamStanding? standing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          TeamFlag(flagUrl: team.flag, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(team.nameEn, style: AppTextStyles.bodyLarge)),
          if (standing != null)
            Text(
              '${standing.pts} PTS',
              style: AppTextStyles.labelLarge.copyWith(
                color: standing.pts > 0
                    ? AppColors.textSecondary
                    : AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

extension _FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
