import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/signin.dart';
import 'state/auth_state.dart';
import 'state/report_state.dart';

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
