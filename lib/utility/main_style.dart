import 'package:flutter/material.dart';

class MainStyle {
  Color darkColor = const Color(0xff0064b7);
  Color promaryColor = const Color(0xff0091ea);
  Color lightColor = const Color(0xff64c1ff);


  MainStyle();
}

Scaffold buildBackground(screenWidth, screenHigh) {
  return Scaffold(
    body: ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        color: Colors.blue.shade500,
        child: ClipPath(
          child: SafeArea(
              child: Stack(
            children: [
              SizedBox(
                  width: screenWidth,
                  height: screenHigh,
                  child: const Text('Clip path')),
            ],
          )),
        ),
        height: screenHigh,
        width: screenWidth,
      ),
    ),
  );
}


class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TOP
    final Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.2017986);
    path0.quadraticBezierTo(size.width * 0.0516667, size.height * 0.1122302,
        size.width * 0.2188889, size.height * 0.1003597);
    path0.cubicTo(
        size.width * 0.3405556,
        size.height * 0.0974820,
        size.width * 0.6283333,
        size.height * 0.1330935,
        size.width * 0.7777778,
        size.height * 0.1320144);
    path0.quadraticBezierTo(size.width * 0.9111111, size.height * 0.1301295,
        size.width, size.height * 0.0848921);
    path0.lineTo(size.width, 0);

    // Bottom
    path0.moveTo(0, size.height * 1.0007194);
    path0.lineTo(0, size.height * 0.8820144);
    path0.quadraticBezierTo(size.width * 0.1937556, size.height * 0.9706906,
        size.width * 0.3361111, size.height * 0.9690647);
    path0.cubicTo(
        size.width * 0.4723556,
        size.height * 0.9600719,
        size.width * 0.6323556,
        size.height * 0.9025180,
        size.width * 0.7922222,
        size.height * 0.9043165);
    path0.quadraticBezierTo(size.width * 0.8812444, size.height * 0.9070216,
        size.width, size.height * 0.9420863);
    path0.lineTo(size.width, size.height * 1.0021583);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



