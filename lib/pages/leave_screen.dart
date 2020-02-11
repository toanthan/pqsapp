import 'package:PQSApp/api/leave_api.dart';
import 'package:PQSApp/models/leave_model.dart';
import 'package:PQSApp/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveScreen extends StatelessWidget {
  Future buildModelDialog(BuildContext context, LeaveModel model) {
    final titleController = TextEditingController();
    titleController.text = model.reason;
    final descriptionController = TextEditingController();
    descriptionController.text = model.fromDate;

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
            title: Text(
                model.id == null ? "New notification" : "Edit notification"),
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
                          LeaveApi().save(
                              Provider.of<AuthState>(context, listen: false)
                                  .user
                                  .id,
                              model.id,
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

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        "Calls",
        style: new TextStyle(fontSize: 20.0),
      ),
    );
  }
}
