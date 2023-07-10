import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';

class VolunteerInfo {
  late String id;
  late String userId;
  late String name;
  late String lastName;
  late String description;
  late double latitude;
  late double longitude;
  late String createdAt;
  late String? updatedAt;
  late List<EventInfo> upcomingEvents;
  late List<EventInfo> currentEvents;
  late List<EventInfo> endedEvents;

  late String profile_image;

  List<String> categories = [];

  VolunteerInfo.fromJson(Map<String, dynamic> json) {
    id = json['volunteer']['id'];
    userId = json['volunteer']['userId'];
    name = json['volunteer']['name'];
    lastName = json['volunteer']['lastName'];
    description = json['volunteer']['description'];
    latitude = json['volunteer']['latitude'].toDouble();
    longitude = json['volunteer']['longitude'].toDouble();
    createdAt = json['volunteer']['createdAt'];
    updatedAt = json['volunteer']['updatedAt'];

    categories = ['Paz', 'Humanitária', 'Animais', 'Social'];
    /*
    if ((json['categories'] as List).isNotEmpty) {
      json['categories'].forEach((v) {
        categories.add(v);
      });
    }*/

    upcomingEvents = [];
    if ((json['upcomming_events'] as List).isNotEmpty) {
      json['upcomming_events'].forEach((v) {
        upcomingEvents.add(EventInfo.fromJson(v));
      });
    }

    currentEvents = [];
    if ((json['active_events'] as List).isNotEmpty) {
      json['active_events'].forEach((v) {
        currentEvents.add(EventInfo.fromJson(v));
      });
    }

    endedEvents = [];
    if ((json['ended_events'] as List).isNotEmpty) {
      json['ended_events'].forEach((v) {
        endedEvents.add(EventInfo.fromJson(v));
      });
    }

    profile_image = '${ApiParams.s3BucketBaseUrl}/${json['volunteer']['userId']}.jpg';
  }
}
