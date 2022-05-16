import 'package:flutter/material.dart';
import '../utility/main_style.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  late double width;
  late double high;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    high = MediaQuery.of(context).size.height;

    return buildBackground(width, high);
  }
  
}
