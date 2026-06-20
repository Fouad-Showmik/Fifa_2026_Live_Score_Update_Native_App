import 'package:fifa_2026_live_score_update/App/models/group_model.dart';
import 'package:fifa_2026_live_score_update/App/teams/team_controller.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/team_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupStandingTable extends ConsumerWidget {
  final GroupModel group;
  const GroupStandingTable({super.key, required this.group});

  static const _headers = ['P', 'W', 'D', 'L'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _headerRow(),
          const Divider(height: 1, color: AppColors.border),
          ...group.teams.asMap().entries.map((e) => Column(
            children: [
              _standingRow(e.value, e.key, teamState),
              if (e.key < group.teams.length - 1)
                const Divider(height: 1, color: AppColors.border),
            ],
          )),
        ],
      ),
    );
  }

  Widget _headerRow() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      children: [
        const SizedBox(width: 16),
        const Expanded(child: Text('Team', style: AppTextStyles.labelSmall)),
        ..._headers.map((h) => _cell(h, style: AppTextStyles.labelSmall)),
        _ptsCell('PTS', style: AppTextStyles.labelSmall),
      ],
    ),
  );

  Widget _standingRow(TeamStanding s, int index, TeamState teamState) {
    final team      = teamState.findById(s.teamId);
    final qualified = index < 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: qualified ? AppColors.finished : Colors.transparent,
            ),
          ),
          if (team != null) ...[
            TeamFlag(flagUrl: team.flag, size: 18),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              team?.nameEn ?? 'Team ${s.teamId}',
              style: AppTextStyles.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ...[s.mp, s.w, s.d, s.l].map((v) => _cell('$v')),
          _ptsCell('${s.pts}', bold: true),
        ],
      ),
    );
  }

  Widget _cell(String v, {TextStyle? style}) => SizedBox(
    width: 30,
    child: Text(
      v,
      style: style ??
          AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    ),
  );

  Widget _ptsCell(String v, {TextStyle? style, bool bold = false}) => SizedBox(
    width: 36,
    child: Text(
      v,
      style: style ??
          (bold
              ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w800)
              : AppTextStyles.labelSmall),
      textAlign: TextAlign.center,
    ),
  );
}
