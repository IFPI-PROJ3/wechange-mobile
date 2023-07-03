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
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageThumb = json['image_thumb'];
  }
}
