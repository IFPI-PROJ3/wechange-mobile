import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/ngo/models/ngo_info.dart';

class NgoService {
  static NgoInfo? ngo;

  static Future<bool> getNgoInfo() async {
    RefreshToken? tokens = await TokenService.getTokens();

    final response = await Dio().get(
      "${ApiParams.apiBaseUrl}/ngo/initial-page",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 200) {
      ngo = NgoInfo.fromJson(response.data);
      return true;
    } else {
      return false;
    }
  }
}
