import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/models/report_model.dart';
import 'package:flutterwhatsapp/pages/call_screen.dart';
import 'package:flutterwhatsapp/pages/report_screen.dart';
import 'package:flutterwhatsapp/pages/status_screen.dart';
import 'package:flutterwhatsapp/pages/task_screen.dart';
import 'package:flutterwhatsapp/state/report_state.dart';
import 'package:provider/provider.dart';

class PQSApp extends StatefulWidget {

  PQSApp();

  @override
  _PQSAppState createState() => _PQSAppState();
}

class _PQSAppState extends State<PQSApp> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;
  final _formKey = GlobalKey<FormState>();

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
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("PQS App"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "REPORTS"),
            Tab(text: "TASKS",),
            Tab(text: "NEWS",),
            Tab(text: "LEAVE",),
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
        onPressed: () => buildShowDialog(context, titleController, descriptionController),
      ),
    );
  }

  Future buildShowDialog(BuildContext context, TextEditingController titleController, TextEditingController descriptionController) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("New report"),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: null,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            String title = titleController.text;
                            String description = descriptionController.text;
                            saveReport(null, title, description);
                            Provider.of<ReportState>(context, listen: false).increase();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
  }
}
