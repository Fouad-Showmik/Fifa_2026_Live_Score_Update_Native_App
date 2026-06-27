import 'package:fifa_2026_live_score_update/App/models/game_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_colors.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_text_styles.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/app_top_bar.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/live_indicator.dart';
import 'package:fifa_2026_live_score_update/Common/widgets/team_flag.dart';
import 'package:flutter/material.dart';

class MatchDetailPage extends StatelessWidget {
  final GameModel match;

  const MatchDetailPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: match.isGroupStage
            ? 'Group ${match.group} · MD${match.matchday}'
            : match.type.toUpperCase(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _scoreBoard(),
          const SizedBox(height: 16),
          _divider(),
          _scorersSection(),
          _divider(),
          _matchInfo(),
        ],
      ),
    );
  }

  // Score board 

Widget _scoreBoard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        // Status badge
        _statusBadge(),
        const SizedBox(height: 20),

        // Flags + score on the same row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: TeamFlag(flagUrl: match.homeTeamFlag ?? '', size: 52)),
            ),
            _scoreBlock(),
            Expanded(
              child: Center(child: TeamFlag(flagUrl: match.awayTeamFlag ?? '', size: 52)),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Team names row below, with a spacer matching the score block width
        Row(
          children: [
            Expanded(
              child: Text(
                match.displayHome,
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 80), // mirrors the score block's horizontal footprint
            Expanded(
              child: Text(
                match.displayAway,
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _statusBadge() {
    if (match.isLive) {
      return LiveIndicator(timeElapsed: match.timeElapsed);
    }
    if (match.isFinished) {
      return Text(
        'FULL TIME',
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.finished,
          letterSpacing: 1.2,
        ),
      );
    }
    return Column(
      children: [
        Text(
          match.displayDate,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          match.displayTime,
          style: AppTextStyles.titleSmall.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget _scoreBlock() {
    final showScore = match.isLive || match.isFinished;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: showScore
          ? Text(
              '${match.homeScore}  -  ${match.awayScore}',
              style: AppTextStyles.scoreDisplay.copyWith(fontSize: 36),
            )
          : Text(
              'vs',
              style: AppTextStyles.labelMedium.copyWith(fontSize: 16),
            ),
    );
  }

  // Scorers 

  Widget _scorersSection() {
    final home = match.homeScorersparsed;
    final away = match.awayScorersparsed;

    if (home.isEmpty && away.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: home.map((s) => _scorerRow(s, isHome: true)).toList(),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: away.map((s) => _scorerRow(s, isHome: false)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scorerRow(String name, {required bool isHome}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: isHome
          ? [
              const Icon(Icons.sports_soccer, size: 13, color: AppColors.gold),
              const SizedBox(width: 6),
              Flexible(
                child: Text(name, style: AppTextStyles.labelMedium),
              ),
            ]
          : [
              Flexible(
                child: Text(
                  name,
                  style: AppTextStyles.labelMedium,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.sports_soccer, size: 13, color: AppColors.gold),
            ],
    ),
  );

  // Match info 

  Widget _matchInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MATCH INFO', style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.1,
          )),
          const SizedBox(height: 12),
          if (match.stadiumNameEn != null)
            _infoRow(Icons.stadium_outlined, match.stadiumNameEn!),
          if (match.stadiumCity != null)
            _infoRow(Icons.place_outlined,
              '${match.stadiumCity}, ${match.stadiumCountry ?? ''}'),
          _infoRow(Icons.calendar_today_outlined, match.displayDate),
          _infoRow(Icons.access_time_outlined, match.displayTime),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: AppTextStyles.titleSmall),
        ),
      ],
    ),
  );

  Widget _divider() => const Divider(
    color: AppColors.border,
    height: 1,
    indent: 20,
    endIndent: 20,
  );
}