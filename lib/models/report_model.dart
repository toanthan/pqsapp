import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportModel {
  int id;
  String title;
  String shortDesc;
  String description;
  String createdAt;
  String avatarUrl;

  ReportModel({this.title, this.shortDesc, this.description, this.createdAt, this.avatarUrl});

  static List<ReportModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<ReportModel>((dynamic item) => ReportModel()
          ..id = item['id']
          ..title = item['title']
          ..description = item['description']
          ..shortDesc = item['shortDesc']
          ..createdAt = item['createdAt']
          ..avatarUrl =
              "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb")
        .toList();
  }

  static ReportModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return ReportModel()
      ..id = data['id']
      ..title = data['title']
      ..description = data['description']
      ..shortDesc = data['shortDesc']
      ..createdAt = data['createdAt']
      ..avatarUrl =
          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb";
  }
}

Future<List<ReportModel>> getReports(int userId) async {
  final String url = 'http://192.168.1.15:8080/reports/' + userId.toString();
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return ReportModel.toList(response.body);
  }
  throw Exception('Failed to load featured movies');
}

Future<ReportModel> saveReport(int id, String title, String description) async {
  final String url = 'http://192.168.1.15:8080/reports/1';

  final response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'id': id, 'title': title, 'description': description}));
  if (response.statusCode == 200) {
    return ReportModel.fromJson(response.body);
  }
  throw Exception('Failed to load data model');
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
