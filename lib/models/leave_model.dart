import 'dart:convert';

class LeaveModel {
  int id;
  String reason;
  String fromDate;
  String toDate;
  String creatorUrl;

  LeaveModel({
    this.id,
    this.reason,
    this.fromDate,
    this.toDate,
    this.creatorUrl,
  });

  static List<LeaveModel> toList(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<LeaveModel>((dynamic item) => LeaveModel()
          ..id = item['id']
          ..reason = item['title']
          ..fromDate = item['fromDate']
          ..toDate = item['toDate']
          ..creatorUrl = item['creatorUrl'])
        .toList();
  }

  static LeaveModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return LeaveModel()
      ..id = data['id']
      ..reason = data['reason']
      ..fromDate = data['fromDate']
      ..toDate = data['toDate'];
  }
}
