import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/App/models/stadium_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Services/api_client.dart';
import 'package:fifa_2026_live_score_update/Services/helpers/api_helpers.dart';

class StadiumService {
  final Dio _dio = ApiClient.create();

  Future<List<StadiumModel>> getStadiums() async {
    final res    = await _dio.get(AppConstants.stadiumsEndpoint);
    final list = ApiHelper.parseList(res.data, 'stadiums')
                 .map(StadiumModel.fromJson).toList();
    list.sort((a, b) => b.capacity.compareTo(a.capacity));
    return list;
  }
}