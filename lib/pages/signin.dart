import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutterwhatsapp/state/auth_state.dart';
import 'package:provider/provider.dart';

import '../auth.dart';
import '../pqsapp_home.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const padding = 25.0;
    return MaterialApp(
        title: 'ĐĂNG NHẬP',
        home: Scaffold(
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/senhong-300.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: padding),
                GoogleSignInButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    Auth.signInWithGoogle(context).whenComplete(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PQSApp(),
                      ));
                    });
                  },
                  darkMode: true,
                  text: "Đăng nhập với Google",
                ),
                SizedBox(height: padding),
              ],
            )));
  }
}
