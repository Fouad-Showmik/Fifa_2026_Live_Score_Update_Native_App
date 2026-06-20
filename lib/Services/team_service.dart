import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/App/models/team_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Services/api_client.dart';
import 'package:fifa_2026_live_score_update/Services/helpers/api_helpers.dart';

class TeamService {
  final Dio _dio = ApiClient.create();

  Future<List<TeamModel>> getTeams() async {
    final res = await _dio.get(AppConstants.teamsEndpoint);
    return ApiHelper.parseList(res.data, 'teams')
           .map(TeamModel.fromJson).toList();
  }
}