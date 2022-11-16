import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowdetect/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

String initRoute = '/authen';

String? initCamera;
List<CameraDescription>? cameras;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverides();

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SharedPreferences pre = await SharedPreferences.getInstance();
  await pre.setString("cameraSelected", "back");
  initCamera = (await pre.getString("cameraSelected"));
  print('initCamera ${initCamera}');

  await Firebase.initializeApp().then(
    (value) async {
      FirebaseAuth.instance.authStateChanges().listen(
        (event) async {
          if (event != null) {
            initRoute = '/userService';
            runApp(const MainApp());
          } else {
            runApp(const MainApp());
          }
        },
      );
    },
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Flow Detect',
      //home: Authen(),
      routes: map,
      initialRoute: initRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((cert, host, port) => true);
  }
}
