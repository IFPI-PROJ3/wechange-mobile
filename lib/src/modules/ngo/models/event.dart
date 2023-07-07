class Event {
  String? id;
  String? title;
  String? description;
  int? volunteersLimit;
  String? startDate;
  String? endDate;
  String? imageThumb;

  Event({
    this.id,
    this.title,
    this.description,
    this.volunteersLimit,
    this.startDate,
    this.endDate,
    this.imageThumb,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    description = json['description'];
    volunteersLimit = json['volunteers_limit'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    imageThumb = json['image_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['volunteers_limit'] = volunteersLimit;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['image_thumb'] = imageThumb;
    return data;
  }
}
