import 'package:intl/intl.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart'; // for date format

class EventInfo {
  String? id;
  String? ngoId;
  String? title;
  String? description;
  bool? quickEvent;
  int? volunteersLimit;
  int? requestsCount;
  int? volunteersCount;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? imageThumb;
  bool? canBeReviewed;

  EventInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngoId = json['ngo_id'];
    title = json['title'];
    description = json['description'];
    quickEvent = json['quick_event'];
    volunteersLimit = json['volunteers_limit'];
    requestsCount = json['requests_count'];
    volunteersCount = json['volunteers_count'];
    startDate = DateFormat('dd/MM/yy').format(DateTime.parse(json['start_date']));
    endDate = DateFormat('dd/MM/yy').format(DateTime.parse(json['end_date']));
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageThumb = '${ApiParams.s3BucketBaseUrl}/${json['image_thumb']}.jpg';
    canBeReviewed = json['can_be_reviewed'];
  }
}
