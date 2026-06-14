class TeamStanding {
  final String teamId;
  final int mp;
  final int w; 
  final int l; 
  final int d; 
  final int pts; 
  final int gf; 
  final int ga; 
  final int gd;

  const TeamStanding({
    required this.teamId,
    required this.mp,
    required this.w,
    required this.l,
    required this.d,
    required this.pts,
    required this.gf,
    required this.ga,
    required this.gd,
  });

  factory TeamStanding.fromJson(Map<String, dynamic> j) => TeamStanding(
    teamId: j['team_id']?.toString() ?? '',
    mp: int.tryParse(j['mp']?.toString() ?? '0') ?? 0,
    w: int.tryParse(j['w']?.toString() ?? '0') ?? 0,
    l: int.tryParse(j['l']?.toString() ?? '0') ?? 0,
    d: int.tryParse(j['d']?.toString() ?? '0') ?? 0,
    pts: int.tryParse(j['pts']?.toString() ?? '0') ?? 0,
    gf: int.tryParse(j['gf']?.toString() ?? '0') ?? 0,
    ga: int.tryParse(j['ga']?.toString() ?? '0') ?? 0,
    gd: int.tryParse(j['gd']?.toString() ?? '0') ?? 0,
  );
}

class GroupModel {
  final String name;
  final List<TeamStanding> teams;

  const GroupModel({required this.name, required this.teams});

  factory GroupModel.fromJson(Map<String, dynamic> j) {
    final raw = j['teams'] as List<dynamic>? ?? [];
    final standings =
        raw
            .map((t) => TeamStanding.fromJson(t as Map<String, dynamic>))
            .toList()
          ..sort((a, b) {
            if (b.pts != a.pts) return b.pts.compareTo(a.pts);
            if (b.gd != a.gd) return b.gd.compareTo(a.gd);
            return b.gf.compareTo(a.gf);
          });
    return GroupModel(name: j['name']?.toString() ?? '', teams: standings);
  }
}
