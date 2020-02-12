import 'dart:convert';

class TaskModel {
  int id;
  String title;
  String description;
  String createdAt;

  String creatorUrl;
  String assignToUrl;

  TaskModel({
    this.title,
    this.description,
    this.createdAt,
    this.creatorUrl,
    this.assignToUrl,
  });

  static List<TaskModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<TaskModel>((dynamic item) => TaskModel()
          ..id = item['id']
          ..title = item['title']
          ..description = item['description']
          ..createdAt = item['createdAt']
          ..creatorUrl = item['creatorUrl']
          ..assignToUrl = item['assignToUrl'])
        .toList();
  }

  static TaskModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return TaskModel()
      ..id = data['id']
      ..title = data['title']
      ..description = data['description']
      ..createdAt = data['createdAt'];
  }
}
