import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/report_model.dart';
import '../state/auth_state.dart';
import '../state/report_state.dart';

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
                    onTap: () {
                      buildShowDialog(
                          context,
                          reportSnap.data[index].id,
                          reportSnap.data[index].title,
                          reportSnap.data[index].description);
                    },
                    leading: new CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          new NetworkImage(reportSnap.data[index].avatarUrl),
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
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        reportSnap.data[index].shortDesc,
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          future: getReports(
              Provider.of<AuthState>(context, listen: false).userId)),
    );
  }

  Future buildShowDialog(
      BuildContext context, int id, String title, String description) {
    final titleController = TextEditingController();
    titleController.text = title;
    final descriptionController = TextEditingController();
    descriptionController.text = description;

    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit report"),
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
                      child: Text("Save"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          String title = titleController.text;
                          String description = descriptionController.text;
                          saveReport(id, title, description);
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
