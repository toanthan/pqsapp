import 'dart:convert';

import 'package:PQSApp/common.dart';
import 'package:PQSApp/models/task_model.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  Future<List<TaskModel>> list(int userId) async {
    final String url = API_HOST + '/notifications/' + userId.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TaskModel.toList(response.body);
    }
    throw Exception('Failed to load featured notifications');
  }

  Future<TaskModel> save(
      final int userId, int id, String title, String description) async {
    final String url = API_HOST + '/notifications/' + userId.toString();

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({'id': id, 'title': title, 'description': description}));
    if (response.statusCode == 200) {
      return TaskModel.fromJson(response.body);
    }
    throw Exception('Failed to load data model');
  }
}
