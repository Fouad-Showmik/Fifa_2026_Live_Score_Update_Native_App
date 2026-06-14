class TeamModel {
  final String id;
  final String nameEn;
  final String nameFa;
  final String flag;
  final String fifaCode;
  final String iso2;
  final String group;

  const TeamModel({
    required this.id,
    required this.nameEn,
    required this.nameFa,
    required this.flag,
    required this.fifaCode,
    required this.iso2,
    required this.group,
  });

  factory TeamModel.fromJson(Map<String, dynamic> j) => TeamModel(
    id: j['id']?.toString() ?? '',
    nameEn: j['name_en']?.toString() ?? '',
    nameFa: j['name_fa']?.toString() ?? '',
    flag: j['flag']?.toString() ?? '',
    fifaCode: j['fifa_code']?.toString() ?? '',
    iso2: j['iso2']?.toString() ?? '',
    group: j['groups']?.toString() ?? '',
  );
}
