import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/App/models/game_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Common/exeptions/app_exception.dart';
import 'package:fifa_2026_live_score_update/Services/api_client.dart';
import 'package:fifa_2026_live_score_update/Services/helpers/api_helpers.dart';

class GameService {
  final Dio _dio = ApiClient.create();

  Future<List<GameModel>> getGames() async {
    try {
      // Parallel fetch
      final results = await Future.wait([
        _dio.get(AppConstants.gamesEndpoint),
        _dio.get(AppConstants.teamsEndpoint),
        _dio.get(AppConstants.stadiumsEndpoint),
      ]);

      // Extract raw lists using helper
      final rawGames = ApiHelper.parseList(results[0].data, 'games');
      final rawTeams = ApiHelper.parseList(results[1].data, 'teams');
      final rawStadiums = ApiHelper.parseList(results[2].data, 'stadiums');

      final teamMap = <String, Map<String, dynamic>>{
        for (final t in rawTeams) t['id'].toString(): t,
      };
      final stadiumMap = <String, Map<String, dynamic>>{
        for (final s in rawStadiums) s['id'].toString(): s,
      };

      // Parse
      return rawGames.map((g) {
        final model = GameModel.fromJson(g);
        final homeTeam = teamMap[model.homeTeamId];
        final awayTeam = teamMap[model.awayTeamId];
        final stadium = stadiumMap[model.stadiumId];

        model.homeTeamFlag = homeTeam?['flag']?.toString();
        model.awayTeamFlag = awayTeam?['flag']?.toString();
        model.stadiumNameEn = stadium?['name_en']?.toString();
        model.stadiumCity = stadium?['city_en']?.toString();
        model.stadiumCountry = stadium?['country_en']?.toString();

        return model;
      }).toList();

    } on DioException catch (e) {
      // Interceptor already wrapped network errors into AppException
      throw e.error is AppException
          ? e.error as AppException
          : const AppException('Unexpected error.');
    } catch (e) {
      // Covers JSON parse errors, cast failures, etc.
      throw const AppException('Failed to process match data.');
    }
  }
}