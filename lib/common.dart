import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var API_HOST = 'http://192.168.1.253:8080';

void showOkDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(
            top: ScreenUtil().setHeight(50),
            bottom: ScreenUtil().setHeight(20),
            right: ScreenUtil().setWidth(20),
            left: ScreenUtil().setWidth(20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          content: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.white,
              child: Text(
                "Ok",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: ScreenUtil().setSp(50),
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
          elevation: 10,
        );
      });
}
