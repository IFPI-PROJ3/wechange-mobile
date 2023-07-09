import 'package:wechange_mobile/src/modules/common/api_params.dart';

class VolunteerRequest {
  String? id;
  String? event_id;
  String? volunteer_id;
  String? volunteer_name;
  String? volunteer_email;
  String? profile_image;
  VolunteerRequest({this.id, this.event_id, this.volunteer_id, this.volunteer_name, this.volunteer_email});

  VolunteerRequest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    event_id = json['event_id'];
    volunteer_id = json['volunteer_id'];
    volunteer_name = json['volunteer_name'];
    volunteer_email = json['volunteer_email'];
    profile_image = '${ApiParams.s3BucketBaseUrl}/${json['userId']}.jpg';
  }
}
