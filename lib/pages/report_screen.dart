import 'package:PQSApp/api/report_api.dart';
import 'package:PQSApp/models/report_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/auth_state.dart';
import '../state/report_state.dart';

class ReportScreen extends StatefulWidget {
  @override
  ReportScreenState createState() {
    return ReportScreenState();
  }

  Future buildModelDialog(BuildContext context, ReportModel report) {
    final titleController = TextEditingController();
    titleController.text = report.title;
    final descriptionController = TextEditingController();
    descriptionController.text = report.description;

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
            title: Text(report.id == null ? "New report" : "Edit report"),
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
                    padding: EdgeInsets.all(8.0),
                    child: DateTimeField(
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: 'Date'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2025));
                      },
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
                          ReportApi().save(
                              Provider.of<AuthState>(context, listen: false)
                                  .user
                                  .id,
                              report.id,
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

class ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Consumer<ReportState>(
      builder: (context, state, child) => FutureBuilder(
          future: ReportApi()
              .list(Provider.of<AuthState>(context, listen: false).user.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    onTap: () {
                      widget.buildModelDialog(context, snapshot.data[index]);
                    },
                    leading: new CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          new NetworkImage(snapshot.data[index].avatarUrl),
                    ),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          snapshot.data[index].title,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          snapshot.data[index].createdAt,
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        snapshot.data[index].description,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
