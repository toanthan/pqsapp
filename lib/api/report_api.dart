import 'dart:convert';

import 'package:PQSApp/common.dart';
import 'package:PQSApp/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportApi {
  Future<List<ReportModel>> getReports(int userId) async {
    final String url = API_HOST + '/reports/' + userId.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ReportModel.toList(response.body);
    }
    throw Exception('Failed to load featured movies');
  }

  Future<ReportModel> saveReport(
      final int userId, int id, String title, String description) async {
    final String url = API_HOST + '/reports/' + userId.toString();

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({'id': id, 'title': title, 'description': description}));
    if (response.statusCode == 200) {
      return ReportModel.fromJson(response.body);
    }
    throw Exception('Failed to load data model');
  }
}
