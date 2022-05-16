import 'package:flowdetect/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

String initRoute = '/authen';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Authen(),
      routes: map,
      initialRoute: initRoute,
    );
  }
}
