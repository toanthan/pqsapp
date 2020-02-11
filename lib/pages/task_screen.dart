import 'package:flutter/material.dart';

import '../models/report_model.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() {
    return new TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(reports[i].avatarUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  reports[i].title,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  reports[i].createdAt,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                reports[i].description,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
