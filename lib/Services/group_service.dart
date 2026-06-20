import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/App/models/group_model.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Services/api_client.dart';
import 'package:fifa_2026_live_score_update/Services/helpers/api_helpers.dart';

class GroupService {
  final Dio _dio = ApiClient.create();

  Future<List<GroupModel>> getGroups() async {
    final res    = await _dio.get(AppConstants.groupsEndpoint);
    final list = ApiHelper.parseList(res.data, 'groups')
                 .map(GroupModel.fromJson).toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}