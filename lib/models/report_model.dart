import 'dart:convert';

class ReportModel {
  int id;
  String title;
  String description;
  String createdAt;
  String avatarUrl;

  ReportModel({this.title, this.description, this.createdAt, this.avatarUrl});

  static List<ReportModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<ReportModel>((dynamic item) => ReportModel()
          ..id = item['id']
          ..title = item['title']
          ..description = item['description']
          ..createdAt = item['createdAt']
          ..avatarUrl = item['avatarUrl'])
        .toList();
  }

  static ReportModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return ReportModel()
      ..id = data['id']
      ..title = data['title']
      ..description = data['description']
      ..createdAt = data['createdAt'];
  }
}
