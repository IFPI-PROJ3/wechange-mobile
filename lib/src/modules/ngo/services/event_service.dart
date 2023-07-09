import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
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

  static Future<Event?> editEvent(EventInfo event) async {
    RefreshToken? tokens = await TokenService.getTokens();

    final response = await Dio().put(
      "${ApiParams.apiBaseUrl}/event/edit/${event.id}",
      data: event.toUpdateJson(),
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 200) {
      return Event.fromJson(response.data);
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    return null;
  }

  static Future<void> cancelEvent(EventInfo event) async {
    RefreshToken? tokens = await TokenService.getTokens();

    final response = await Dio().put(
      "${ApiParams.apiBaseUrl}/event/cancel/${event.id}",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 204) {
      return;
    }
    return;
  }

  static Future<List<EventInfo>> getEventFeed() async {
    throw Exception();
  }

  static Future<Event> getEvent() async {
    throw Exception();
  }
}
