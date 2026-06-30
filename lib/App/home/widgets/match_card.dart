import 'package:fifa_2026_live_score_update/App/home/pages/match_details_page.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/live_indicator.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/team_flag.dart';
import 'package:flutter/material.dart';
import 'package:fifa_2026_live_score_update/App/models/game_model.dart';

class MatchCard extends StatelessWidget {
  final GameModel match;
  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MatchDetailPage(match: match)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 12),
              _teamsRow(),
              const SizedBox(height: 10),
              _venueRow(),
            ],
          ),
        ),
      ),
    );
  }

  // Header — group tag + time/status

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _groupTag(
        label: match.stageLabel,
      ),
      _timeWidget(),
    ],
  );

  Widget _timeWidget() {
    if (match.isLive) {
      return LiveIndicator(timeElapsed: match.timeElapsed);
    }
    if (match.isFinished) {
      return Text(
        'FT',
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.finished,
          fontSize: 13,
        ),
      );
    }
    // Upcoming: show date + time stacked
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          match.displayDate,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
        Text(
          match.displayTime,
          style: AppTextStyles.titleSmall.copyWith(fontSize: 13),
        ),
      ],
    );
  }

  // Teams row — flags, names, score

  Widget _teamsRow() {
    final showScore = match.isLive || match.isFinished;
    return Row(
      children: [
        Expanded(
          child: _teamName(
            flagUrl: match.homeTeamFlag ?? '',
            name: match.displayHome,
            reversed: false,
          ),
        ),
        const SizedBox(width: 8),
        showScore
            ? Text(
                '${match.homeScore} - ${match.awayScore}',
                style: AppTextStyles.scoreDisplay,
              )
            : Text(
                'vs',
                style: AppTextStyles.labelMedium.copyWith(fontSize: 12),
              ),
        const SizedBox(width: 8),
        Expanded(
          child: _teamName(
            flagUrl: match.awayTeamFlag ?? '',
            name: match.displayAway,
            reversed: true,
          ),
        ),
      ],
    );
  }

  // Venue row — stadium name + city

  Widget _venueRow() {
    if (match.stadiumNameEn == null) return const SizedBox.shrink();
    final label = [
      match.stadiumNameEn,
      match.stadiumCity,
    ].where((s) => s != null && s.isNotEmpty).join(' · ');

    return Row(
      children: [
        const Icon(
          Icons.place_outlined,
          size: 12,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

Widget _groupTag({required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.groupTagBg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textSecondary,
      ),
    ),
  );
}

  Widget _teamName({
    required String flagUrl,
    required String name,
    required bool reversed,
  }) {
    final flag = TeamFlag(flagUrl: flagUrl, size: 20);

    final text = Flexible(
      child: Text(
        name,
        style: AppTextStyles.titleMedium,
        overflow: TextOverflow.ellipsis,
        textAlign: reversed ? TextAlign.right : TextAlign.left,
      ),
    );

    return Row(
      mainAxisAlignment: reversed
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: reversed
          ? [text, const SizedBox(width: 8), flag]
          : [flag, const SizedBox(width: 8), text],
    );
  }
}
