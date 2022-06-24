import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowdetect/router.dart';
import 'package:flowdetect/screens/CameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

String initRoute = '/authen';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  //cameras = await availableCameras();

  //final firstCamera = cameras.first;

  // try {
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   debugPrint(e.code +" "+e.description.toString());
  // }

  // Obtain a list of the available cameras on the device.
  //final cameras = await availableCameras();

  await Firebase.initializeApp().then((value) async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        initRoute = '/userService';
        runApp(const MainApp());
      } else {
        runApp(const MainApp());
      }
    });
  });

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
      //home: Authen(),
      routes: map,
      initialRoute: initRoute,
    );
  }
}
