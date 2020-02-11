import 'package:PQSApp/api/task_api.dart';
import 'package:PQSApp/models/task_model.dart';
import 'package:PQSApp/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/report_model.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() {
    return new TaskScreenState();
  }

  Future buildModelDialog(BuildContext context, TaskModel task) {
    final titleController = TextEditingController();
    titleController.text = task.title;
    final descriptionController = TextEditingController();
    descriptionController.text = task.description;

    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(5),
            title: Text(task.id == null ? "New task" : "Edit task"),
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
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: null,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          String title = titleController.text;
                          String description = descriptionController.text;
                          TaskApi().save(
                              Provider.of<AuthState>(context, listen: false)
                                  .user
                                  .id,
                              task.id,
                              title,
                              description);
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
