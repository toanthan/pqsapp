import 'package:PQSApp/models/leave_model.dart';
import 'package:PQSApp/models/notification_model.dart';
import 'package:PQSApp/models/report_model.dart';
import 'package:PQSApp/models/task_model.dart';
import 'package:flutter/material.dart';

import 'pages/leave_screen.dart';
import 'pages/notification_screen.dart';
import 'pages/report_screen.dart';
import 'pages/task_screen.dart';

class ReportApp extends StatefulWidget {
  ReportApp();

  @override
  _ReportAppState createState() => _ReportAppState();
}

class _ReportAppState extends State<ReportApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PQS App"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "REPORTS"),
            Tab(
              text: "TASKS",
            ),
            Tab(
              text: "NEWS",
            ),
            Tab(
              text: "LEAVE",
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ReportScreen(),
          TaskScreen(),
          NotificationScreen(),
          LeaveScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => {
          if (_tabController.index == 0)
            ReportScreen().buildModelDialog(context, ReportModel())
          else if (_tabController.index == 1)
            TaskScreen().buildModelDialog(context, TaskModel())
          else if (_tabController.index == 2)
            NotificationScreen().buildModelDialog(context, NotificationModel())
          else if (_tabController.index == 3)
            LeaveScreen().buildModelDialog(context, LeaveModel())
        },
      ),
    );
  }
}
