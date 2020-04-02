import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const padding = 25.0;
    ScreenUtil.init(context);
    return MaterialApp(
        title: 'LoadingScreen',
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: ListView(
              padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(550),
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
              ],
            )));
  }
}
