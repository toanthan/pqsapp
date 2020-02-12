import 'dart:convert';

import 'package:PQSApp/common.dart';
import 'package:PQSApp/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportApi {
  Future<List<ReportModel>> list(int userId, String key, int time) async {
    final String url = API_HOST +
        '/reports/' +
        userId.toString() +
        "/" +
        key +
        "?" +
        time.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ReportModel.toList(response.body);
    }
    throw Exception('Failed to load featured reports');
  }

  Future<ReportModel> save(final int userId, String key, int id, String title,
      String description, String date) async {
    final String url = API_HOST + '/reports/' + userId.toString() + "/" + key;

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'id': id,
          'title': title,
          'description': description,
          'createdAt': date
        }));
    if (response.statusCode == 200) {
      return ReportModel.fromJson(response.body);
    }
    throw Exception('Failed to load data model');
  }
}
