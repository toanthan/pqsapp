import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../auth.dart';
import '../common.dart';
import '../pqsapp_home.dart';
import '../state/auth_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const padding = 25.0;
    ScreenUtil.init(context);
    return MaterialApp(
        title: 'ĐĂNG NHẬP',
        home: Scaffold(
            body: ListView(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(500),
            left: ScreenUtil().setWidth(140),
            right: ScreenUtil().setWidth(140),
          ),
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setHeight(360),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/senhong-notext.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ]),
            SizedBox(height: padding),
            FlatButton(
                color: Color.fromRGBO(221, 75, 57, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  "Đăng nhập bằng Google",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: ScreenUtil().setSp(50)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Auth.signInWithGoogle(context).whenComplete(() {
                    if (Provider.of<AuthState>(context, listen: false)
                        .hasAuth()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportApp(),
                      ));
                      return;
                    }
                  }).then((errorCode) {
                    Navigator.pop(context);
                    showOkDialog(context, "Không thể đăng nhập");
                  });
                }),
            SizedBox(height: padding),
          ],
        )));
  }
}
