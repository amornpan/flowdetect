import 'package:camera/camera.dart';
import 'package:flowdetect/screens/video_page.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  late double screenWidth;
  late double screenHigh;

  @override
  void initState() {
    _initCamera(widget.cameras![0]);
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera(CameraDescription cameraDescription) async {
    //dynamic stationCode;
    final cameras = await availableCameras();
    //final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);

      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'บันทึกวีดีโอขณะวัตถุเคลื่อนผ่าน',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //fontSize: 13,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.blue.shade500,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ClipPath(
                //   clipper: CustomClipPath(),
                //   child: Container(
                //     color: Colors.blue.shade500,
                //     child: const ClipPath(),
                //     height: screenHigh,
                //     width: screenWidth,
                //   ),
                // ),

                CameraPreview(_cameraController),

                CustomPaint(
                  size: Size(screenWidth, screenHigh),
                  painter: Line(),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
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

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Rectangle extends CustomPainter {
  bool? isFilled;
  Rectangle({this.isFilled});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    if (isFilled != null) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = 5;
    Offset offset = Offset(size.width * 0.5, size.height);

    Rect rect = Rect.fromCenter(center: offset, width: 50, height: 50);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant Rectangle oldDelegate) {
    return false;
  }
}

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Read Reference
    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;

    Offset startingOffset = Offset(size.width * 0.10, size.height * 0.75);
    Offset endingOffset = Offset(size.width * 0.90, size.height * 0.75);

    canvas.drawLine(startingOffset, endingOffset, paint);

    // Green Reference
    Paint paint2 = Paint();
    paint2.color = const Color.fromARGB(255, 13, 132, 29);
    paint2.strokeWidth = 5;
    paint2.strokeCap = StrokeCap.round;
    Offset startingOffset2 = Offset(size.width * 0.20, size.height * 0.25);
    Offset endingOffset2 = Offset(size.width * 0.80, size.height * 0.25);
    canvas.drawLine(startingOffset2, endingOffset2, paint2);

    // Yellow_left Reference
    Paint paint3 = Paint();
    paint3.color = const Color.fromARGB(255, 223, 194, 7);
    paint3.strokeWidth = 5;
    paint3.strokeCap = StrokeCap.round;
    Offset startingOffset3 = Offset(size.width * 0.19, size.height * 0.20);
    Offset endingOffset3 = Offset(size.width * 0.07, size.height * 0.80);
    canvas.drawLine(startingOffset3, endingOffset3, paint3);

    // Yellow_Right Reference
    Paint paint4 = Paint();
    paint4.color = const Color.fromARGB(255, 223, 194, 7);
    paint4.strokeWidth = 5;
    paint4.strokeCap = StrokeCap.round;
    Offset startingOffset4 = Offset(size.width * 0.81, size.height * 0.2);
    Offset endingOffset4 = Offset(size.width * 0.93, size.height * 0.8);
    canvas.drawLine(startingOffset4, endingOffset4, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
