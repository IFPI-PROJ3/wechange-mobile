import 'package:intl/intl.dart'; // for date format

class EventInfo {
  String? id;
  String? ngoId;
  String? title;
  String? description;
  bool? quickEvent;
  int? volunteersLimit;
  int? volunteersCount;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? imageThumb;

  EventInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngoId = json['ngo_id'];
    title = json['title'];
    description = json['description'];
    quickEvent = json['quick_event'];
    volunteersLimit = json['volunteers_limit'];
    volunteersCount = json['volunteers_count'];
    startDate = DateFormat('MM/dd/yy').format(DateTime.parse(json['start_date']));
    endDate = DateFormat('MM/dd/yy').format(DateTime.parse(json['end_date']));
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageThumb =
        "https://scontent.fthe1-1.fna.fbcdn.net/v/t1.6435-9/54517417_10157582374334947_7228062009319751680_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=qMJ_e-R4gIUAX8XPgbB&_nc_ht=scontent.fthe1-1.fna&oh=00_AfDAzPnvTbNNsS7ZeGiKzUZPtnyIs6UgUF_ZKVkcjI0GPQ&oe=64CD8FC1";
    //imageThumb = json['image_thumb'];
    //imageThumb = ApiParams.s3BucketBaseUrl + json['image_thumb'];
  }
}
