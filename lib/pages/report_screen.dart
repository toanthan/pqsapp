import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/state/report_state.dart';
import 'package:provider/provider.dart';
import '../models/report_model.dart';

class ReportScreen extends StatefulWidget {
  @override
  ReportScreenState createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportState>(
        builder: (context, state, child) => FutureBuilder(
      builder: (context, reportSnap) {
        if (!reportSnap.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: reportSnap.data.length,
          itemBuilder: (context, index) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new ListTile(
                leading: new CircleAvatar(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                  backgroundImage: new NetworkImage(reportSnap.data[index].avatarUrl),
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      reportSnap.data[index].title,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      reportSnap.data[index].createdAt,
                      style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
                subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    reportSnap.data[index].shortDesc,
                    style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
        );
      },
      future: getReports(),
    ));
  }
}
