import 'package:fifa_2026_live_score_update/Common/enums/app_enums.dart';
import 'package:fifa_2026_live_score_update/Common/utlis/app_utils.dart';

class GameModel {
  final String id;
  final String homeTeamId;
  final String awayTeamId;
  final int homeScore;
  final int awayScore;
  final String homeScorers;
  final String awayScorers;
  final String group;
  final String matchday;
  final DateTime? localDate;
  final String stadiumId;
  final MatchStatus status;
  final String timeElapsed;
  final String type;
  final String homeTeamNameEn;
  final String awayTeamNameEn;
  final String homeTeamNameFa;
  final String awayTeamNameFa;

  // Enriched after joining with teams data
  String? homeTeamFlag;
  String? awayTeamFlag;

  // Enriched after joining with stadiums data
  String? stadiumNameEn;
  String? stadiumCity;
  String? stadiumCountry;

  GameModel({
    required this.id,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.homeScore,
    required this.awayScore,
    required this.homeScorers,
    required this.awayScorers,
    required this.group,
    required this.matchday,
    required this.localDate,
    required this.stadiumId,
    required this.status,
    required this.timeElapsed,
    required this.type,
    required this.homeTeamNameEn,
    required this.awayTeamNameEn,
    required this.homeTeamNameFa,
    required this.awayTeamNameFa,
    this.homeTeamFlag,
    this.awayTeamFlag,
    this.stadiumNameEn,
    this.stadiumCity,
    this.stadiumCountry,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    final timeElapsed = json['time_elapsed']?.toString() ?? 'notstarted';
    final finished = json['finished']?.toString() ?? 'FALSE';

    return GameModel(
      id: json['id']?.toString() ?? '',
      homeTeamId: json['home_team_id']?.toString() ?? '',
      awayTeamId: json['away_team_id']?.toString() ?? '',
      homeScore: int.tryParse(json['home_score']?.toString() ?? '0') ?? 0,
      awayScore: int.tryParse(json['away_score']?.toString() ?? '0') ?? 0,
      homeScorers: json['home_scorers']?.toString() ?? '',
      awayScorers: json['away_scorers']?.toString() ?? '',
      group: json['group']?.toString() ?? '',
      matchday: json['matchday']?.toString() ?? '',
      localDate: AppUtils.parseLocalDate(json['local_date']?.toString() ?? ''),
      stadiumId: json['stadium_id']?.toString() ?? '',
      status: MatchStatus.fromApi(timeElapsed, finished),
      timeElapsed: timeElapsed,
      type: json['type']?.toString() ?? '',
      homeTeamNameEn: json['home_team_name_en']?.toString() ?? '',
      awayTeamNameEn: json['away_team_name_en']?.toString() ?? '',
      homeTeamNameFa: json['home_team_name_fa']?.toString() ?? '',
      awayTeamNameFa: json['away_team_name_fa']?.toString() ?? '',
    );
  }

  //getters for UI logic

  bool get isLive => status.isLive;
  bool get isFinished => status.isFinished;
  bool get isUpcoming => status.isUpcoming;

  String get displayTime => AppUtils.formatTime(localDate);
  String get dateKey => AppUtils.dateKey(localDate);
  String get displayHome => homeTeamNameEn.isNotEmpty ? homeTeamNameEn : 'TBD';
  String get displayAway => awayTeamNameEn.isNotEmpty ? awayTeamNameEn : 'TBD';
  bool get isGroupStage => type == 'group';
  String get displayDate => AppUtils.formatTabDate(localDate);
}
