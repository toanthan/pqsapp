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

List<ReportModel> reports = [
  new ReportModel(
      title: "Pawan Kumar",
      description: "Hey Flutter, You are so amazing !",
      createdAt: "15:30",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
  new ReportModel(
      title: "Harvey Spectre",
      description: "Hey I have hacked whatsapp!",
      createdAt: "17:30",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
  new ReportModel(
      title: "Mike Ross",
      description: "Wassup !",
      createdAt: "5:00",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
  new ReportModel(
      title: "Rachel",
      description: "I'm good!",
      createdAt: "10:30",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
  new ReportModel(
      title: "Barry Allen",
      description: "I'm the fastest man alive!",
      createdAt: "12:30",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
  new ReportModel(
      title: "Joe West",
      description: "Hey Flutter, You are so cool !",
      createdAt: "15:30",
      avatarUrl:
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
];
