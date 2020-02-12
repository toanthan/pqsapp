import 'dart:convert';

class NotificationModel {
  int id;
  String title;
  String description;
  String createdAt;
  String creatorUrl;
  String assignToUrl;

  NotificationModel({
    this.title,
    this.description,
    this.createdAt,
    this.creatorUrl,
    this.assignToUrl,
  });

  static List<NotificationModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<NotificationModel>((dynamic item) => NotificationModel()
          ..id = item['id']
          ..title = item['title']
          ..description = item['description']
          ..createdAt = item['createdAt']
          ..creatorUrl = item['creatorUrl']
          ..assignToUrl = item['assignToUrl'])
        .toList();
  }

  static NotificationModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return NotificationModel()
      ..id = data['id']
      ..title = data['title']
      ..description = data['description']
      ..createdAt = data['createdAt'];
  }
}
