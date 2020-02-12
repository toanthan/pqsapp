import 'dart:convert';

import 'package:PQSApp/common.dart';
import 'package:PQSApp/models/leave_model.dart';
import 'package:http/http.dart' as http;

class LeaveApi {
  Future<List<LeaveModel>> list(int userId) async {
    final String url = API_HOST + '/leaves/' + userId.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return LeaveModel.toList(response.body);
    }
    throw Exception('Failed to load featured leaves');
  }

  Future<LeaveModel> save(
      final int userId, int id, String title, String description) async {
    final String url = API_HOST + '/leaves/' + userId.toString();

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({'id': id, 'title': title, 'description': description}));
    if (response.statusCode == 200) {
      return LeaveModel.fromJson(response.body);
    }
    throw Exception('Failed to load data model');
  }
}
