import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/ngo/models/event.dart';

class EventService {
  static Future<Event?> newEvent(Event event) async {
    RefreshToken? tokens = await TokenService.getTokens();

    //try {
    final response = await Dio().post(
      "${ApiParams.apiBaseUrl}/event/new",
      data: event.toJson(),
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 201) {
      return Event.fromJson(response.data);
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    return null;
  }
}
