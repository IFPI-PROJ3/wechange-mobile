import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/volunteer/models/volunteer_info.dart';

class VolunteerService {
  static VolunteerInfo? volunteer;

  static Future<bool> getVolunteerInfoInitialPage() async {
    RefreshToken? tokens = await TokenService.getTokens();

    try {
      final response = await Dio().get(
        "${ApiParams.apiBaseUrl}/volunteer/initial-page",
        options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
      );

      if (response.statusCode == 200) {
        volunteer = VolunteerInfo.fromJson(response.data);
        return true;
      }
    } on Exception {}

    return false;
  }

  static Future<VolunteerInfo?> getVolunteerInfoView(String id) async {
    RefreshToken? tokens = await TokenService.getTokens();

    try {
      final response = await Dio().get(
        "${ApiParams.apiBaseUrl}/volunteer/$id",
        options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
      );

      if (response.statusCode == 200) {
        volunteer = VolunteerInfo.fromJson(response.data);
        return volunteer;
      }
    } on Exception {}

    return null;
  }
}
