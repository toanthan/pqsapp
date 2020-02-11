import 'dart:async';

import 'package:PQSApp/pages/signin.dart';
import 'package:PQSApp/pqsapp_home.dart';
import 'package:PQSApp/settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
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
  Future<bool> loadAuth(BuildContext context) async {
    String auth = await Settings().getAuth();
    if (auth != null) {
      Provider.of<AuthState>(context, listen: false)
          .updateAuth(UserModel.fromJson(auth));
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PQ Report",
      theme: ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data) {
            return ReportApp();
          }
          return LoginScreen();
        },
        future: loadAuth(context),
      ),
    );
  }
}
