import 'dart:convert';

class TaskModel {
  int id;
  String reason;
  String fromDate;
  String toDate;
  String creatorUrl;

  TaskModel({
    this.id,
    this.reason,
    this.fromDate,
    this.toDate,
    this.creatorUrl,
  });

  static List<TaskModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<TaskModel>((dynamic item) => TaskModel()
          ..id = item['id']
          ..reason = item['title']
          ..fromDate = item['fromDate']
          ..toDate = item['toDate']
          ..creatorUrl = item['creatorUrl'])
        .toList();
  }

  static TaskModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return TaskModel()
      ..id = data['id']
      ..reason = data['reason']
      ..fromDate = data['fromDate']
      ..toDate = data['toDate'];
  }
}
