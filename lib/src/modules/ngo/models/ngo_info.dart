import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';

class NgoInfo {
  late String id;
  late String userId;
  late String name;
  late String description;
  late double latitude;
  late double longitude;
  late String createdAt;
  late String? updatedAt;
  late double averageRating;
  late List<EventInfo> upcomingEvents;
  late List<EventInfo> currentEvents;
  late List<EventInfo> endedEvents;

  late String profile_image;

  NgoInfo.fromJson(Map<String, dynamic> json) {
    id = json['ngo']['id'];
    userId = json['ngo']['userId'];
    name = json['ngo']['name'];
    description = json['ngo']['description'];
    latitude = json['ngo']['latitude'].toDouble();
    longitude = json['ngo']['longitude'].toDouble();
    createdAt = json['ngo']['createdAt'];
    updatedAt = json['ngo']['updatedAt'];
    averageRating = json['average_rating'].toDouble();

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
        currentEvents.add(EventInfo.fromJson(v));
      });
    }

    profile_image = '${ApiParams.s3BucketBaseUrl}/${json['ngo']['userId']}.jpg';
  }
}
