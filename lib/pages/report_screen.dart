import 'package:flutter/material.dart';
import '../models/report_model.dart';

class ReportScreen extends StatefulWidget {
  @override
  ReportScreenState createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  List<ReportModel> _reports = <ReportModel>[];

  @override
  void initState() {
    super.initState();

    listenForReports();
  }

  void listenForReports() async {
    List<ReportModel> data = await getReports();
    setState(() {
      _reports = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _reports.length,
      itemBuilder: (context, i) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new ListTile(
                leading: new CircleAvatar(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                  backgroundImage: new NetworkImage(_reports[i].avatarUrl),
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      _reports[i].title,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      _reports[i].createdAt,
                      style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
                subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    _reports[i].description,
                    style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
    );
  }
}
