import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String appName = 'FIFA WORLD CUP 2026';
  static final String baseUrl = dotenv.env['api_base_url'] ?? '';
  static const String gamesEndpoint = '/get/games';
  static const String groupsEndpoint = '/get/groups';
  static const String teamsEndpoint = '/get/teams';
  static const String stadiumsEndpoint = '/get/stadiums';
  static const int pollIntervalSeconds = 10;
}
