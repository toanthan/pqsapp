import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/pages/call_screen.dart';
import 'package:flutterwhatsapp/pages/report_screen.dart';
import 'package:flutterwhatsapp/pages/status_screen.dart';
import 'package:flutterwhatsapp/pages/task_screen.dart';

class PQSApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  PQSApp({this.cameras});

  @override
  _PQSAppState createState() => _PQSAppState();
}

class _PQSAppState extends State<PQSApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
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
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ReportScreen(),
          TaskScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => print("New Task"),
      ),
    );
  }
}
