import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/pages/signin.dart';
import 'package:flutterwhatsapp/pqsapp_home.dart';
import 'package:flutterwhatsapp/state/auth_state.dart';
import 'package:flutterwhatsapp/state/report_state.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ReportState>(create: (_) => ReportState()),
      ChangeNotifierProvider<AuthState>(create: (_) => AuthState())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "PQ Report",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
