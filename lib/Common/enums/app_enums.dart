enum MatchStatus {
  notStarted,
  firstHalf,
  halfTime,
  secondHalf,
  extraTime,
  penalties,
  finished,
  unknown;

  static MatchStatus fromApi(String timeElapsed, String finished) {
    if (finished.toUpperCase() == 'TRUE') return MatchStatus.finished;
    return switch (timeElapsed.toLowerCase()) {
      'notstarted' => MatchStatus.notStarted,
      '1h' || 'first_half' => MatchStatus.firstHalf,
      'ht' || 'half_time' => MatchStatus.halfTime,
      '2h' || 'second_half' => MatchStatus.secondHalf,
      'et' || 'extra_time' => MatchStatus.extraTime,
      'p' || 'penalties' => MatchStatus.penalties,
      'ft' || 'finished' => MatchStatus.finished,
      _ => MatchStatus.unknown,
    };
  }

  bool get isLive =>
      this == firstHalf ||
      this == halfTime ||
      this == secondHalf ||
      this == extraTime ||
      this == penalties;

  bool get isFinished => this == finished;
  bool get isUpcoming => this == notStarted;
}

enum GameType {
  group, r32, r16, quarterFinal, semiFinal, third, final_;

  static GameType fromString(String v) {
    return switch (v.toLowerCase()) {
      'group'  => GameType.group,
      'r32'    => GameType.r32,
      'r16'    => GameType.r16,
      'qf'     => GameType.quarterFinal,
      'sf'     => GameType.semiFinal,
      'third'  => GameType.third,
      'final'  => GameType.final_,
      _        => GameType.group,
    };
  }

  String get displayName => switch (this) {
    GameType.group        => 'Group Stage',
    GameType.r32          => 'Round of 32',
    GameType.r16          => 'Round of 16',
    GameType.quarterFinal => 'Quarter Final',
    GameType.semiFinal    => 'Semi Final',
    GameType.third        => '3rd Place',
    GameType.final_       => 'Final',
  };
}

enum LiveScoreFilter { all, live, finished, upcoming }

enum NavTab { home, fixtures, groups, venues, teams }

enum StadiumCountry {
  all, usa, canada, mexico;

  String get displayName => switch (this) {
    StadiumCountry.all    => 'All',
    StadiumCountry.usa    => 'USA',
    StadiumCountry.canada => 'Canada',
    StadiumCountry.mexico => 'Mexico',
  };
}
