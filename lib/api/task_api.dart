import 'dart:convert';

import 'package:PQSApp/common.dart';
import 'package:PQSApp/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskApi {
  Future<List<TaskModel>> list(int userId, String key) async {
    final String url = API_HOST + '/tasks/' + userId.toString() + "/" + key;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TaskModel.toList(response.body);
    }
    throw Exception('Failed to load featured tasks');
  }

  Future<TaskModel> save(final int userId, final String key, int id,
      String title, String description) async {
    final String url = API_HOST + '/tasks/' + userId.toString() + "/" + key;

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
