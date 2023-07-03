class Event {
  String? title;
  String? description;
  bool? quickEvent;
  int? volunteersLimit;
  String? startDate;
  String? endDate;
  String? imageThumb;

  Event(
      {this.title,
      this.description,
      this.quickEvent,
      this.volunteersLimit,
      this.startDate,
      this.endDate,
      this.imageThumb});

  Event.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    quickEvent = json['quick_event'];
    volunteersLimit = json['volunteers_limit'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    imageThumb = json['image_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['quick_event'] = quickEvent;
    data['volunteers_limit'] = volunteersLimit;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['image_thumb'] = imageThumb;
    return data;
  }
}
