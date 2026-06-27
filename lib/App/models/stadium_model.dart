import 'package:fifa_2026_live_score_update/Common/utlis/app_utils.dart';

class StadiumModel {
  final String id;
  final String nameEn;
  final String nameFa;
  final String fifaName;
  final String cityEn;
  final String cityFa;
  final String countryEn;
  final String countryFa;
  final String region;
  final int capacity;

  const StadiumModel({
    required this.id,
    required this.nameEn,
    required this.nameFa,
    required this.fifaName,
    required this.cityEn,
    required this.cityFa,
    required this.countryEn,
    required this.countryFa,
    required this.capacity,
    required this.region,
  });

  factory StadiumModel.fromJson(Map<String, dynamic> j) => StadiumModel(
    id: j['id']?.toString() ?? '',
    nameEn: j['name_en']?.toString() ?? '',
    nameFa: j['name_fa']?.toString() ?? '',
    fifaName: j['fifa_name']?.toString() ?? '',
    cityEn: j['city_en']?.toString() ?? '',
    cityFa: j['city_fa']?.toString() ?? '',
    countryEn: j['country_en']?.toString() ?? '',
    countryFa: j['country_fa']?.toString() ?? '',
    capacity: j['capacity'] is int
        ? j['capacity'] as int
        : int.tryParse(j['capacity']?.toString() ?? '0') ?? 0,
    region: j['region']?.toString() ?? '',
  );

  //getters for UI logic
  bool get isUSA => countryEn == 'United States';
  bool get isCanada => countryEn == 'Canada';
  bool get isMexico => countryEn == 'Mexico';
  String get formattedCapacity => AppUtils.formatCapacity(capacity);
  String get imagePath => 'assets/stadiums/$id.jpg';
}
