import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';
import 'package:wechange_mobile/src/modules/auth/services/token_service.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/ngo/models/volunteer_request.dart';

class EventVolunteerService {
  static Future<List<VolunteerRequest>> getEventVolunteers(EventInfo event) async {
    RefreshToken? tokens = await TokenService.getTokens();
    List<VolunteerRequest> requests = [];

    //try {
    final response = await Dio().get(
      "${ApiParams.apiBaseUrl}/event-volunteers/${event.id}",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 200) {
      response.data.forEach((v) {
        requests.add(VolunteerRequest.fromJson(v));
      });
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    return requests;
  }

  static Future<List<VolunteerRequest>> getEventRequests(EventInfo event) async {
    RefreshToken? tokens = await TokenService.getTokens();
    List<VolunteerRequest> requests = [];
    //try {
    final response = await Dio().get(
      "${ApiParams.apiBaseUrl}/event-volunteers/requests/${event.id}",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 200) {
      response.data.forEach((v) {
        requests.add(VolunteerRequest.fromJson(v));
      });
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    return requests;
  }

  static Future<void> acceptEventRequest(String id) async {
    RefreshToken? tokens = await TokenService.getTokens();

    //try {
    final response = await Dio().put(
      "${ApiParams.apiBaseUrl}/event-volunteers/accept-request/$id",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 204) {
      return;
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    //return requests;
  }

  static Future<void> refuseEventRequest(String id) async {
    RefreshToken? tokens = await TokenService.getTokens();

    //try {
    final response = await Dio().put(
      "${ApiParams.apiBaseUrl}/event-volunteers/refuse-request/$id",
      options: ApiParams.dioRequestDefaultOptionsAuthBearer(tokens!.accessToken),
    );

    if (response.statusCode == 204) {
      return;
    }
    //} on Exception (ex) {
    //print(ex.toString());
    //}
    //return requests;
  }
}
