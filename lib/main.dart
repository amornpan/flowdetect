<<<<<<< HEAD
=======
import 'dart:io';
//import 'package:camera/camera.dart';
>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowdetect/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
=======
//import 'package:camera/camera.dart';
>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8

String initRoute = '/authen';

Future<void> main() async {
<<<<<<< HEAD
=======
  HttpOverrides.global = MyHttpOverides();

>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
<<<<<<< HEAD
         
        initRoute = '/userService';
        runApp(const MainApp());
      }
      else{
=======
        initRoute = '/userService';
        runApp(const MainApp());
      } else {
>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8
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
<<<<<<< HEAD


=======
>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      //home: Authen(),
      routes: map,
      initialRoute: initRoute,
    );
  }
}
=======
      //home: Authen(),
      routes: map,
      initialRoute: initRoute,
      //debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = ((cert, host, port) => true);
  }
}
>>>>>>> 1547a9325a2248aa6e1eea3ceb0f3728fcb7bbe8
