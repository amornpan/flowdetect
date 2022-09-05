import 'package:camera/camera.dart';
import 'package:flowdetect/screens/video_page.dart';
import 'package:flowdetect/utility/dialog.dart';
import 'package:flutter/material.dart';

late double? y2Reds;
late double? y1Greens;
late double? x1Lefts;
late double? x2Rights;
late double screenWidth;
late double screenHigh;

late double? videoHigh;
late double? videoWidth;

class CameraPage extends StatefulWidget {
  const CameraPage({
    Key? key,
    required this.cameras,
    required this.postgresids,
    this.particleSizes,
  }) : super(key: key);

  final List<CameraDescription>? cameras;
  final int? postgresids;
  final double? particleSizes;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;

  late double? videoaspectRatio;

  int? postgresIntid;

  double? particleSize;

  _showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("ยอมรับ"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("คำแนะนำ"),
      content: const Text(
          "1.ถือกล้องให้นิ่ง\n2.อย่าให้มีสิ่งกีดขวางในกรวยการวัด\n3.ให้วัตถุเคลื่อนที่ผ่านในกรวยการวัด"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    _initCamera(widget.cameras![0]);
    postgresIntid = widget.postgresids;
    particleSize = widget.particleSizes;

    print('## postgresid CameraPage= $postgresIntid');
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera(CameraDescription cameraDescription) async {
    //dynamic stationCode;
    //final cameras = await availableCameras();
    //final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
    setState(() => _isLoading = false);

    _cameraController.value.isInitialized;
    videoWidth = _cameraController.value.previewSize!.height;
    videoHigh = _cameraController.value.previewSize!.width;

    _showAlertDialog(context);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);

      final route = MaterialPageRoute(
        fullscreenDialog: false,
        builder: (_) => VideoPage(
          filePath: file.path,
          postgresids: postgresIntid,
          y1Greens: y1Greens,
          y2Reds: y2Reds,
          x1Lefts: x1Lefts,
          x2Rights: x2Rights,
          particleSizes : particleSize,

        ),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/userService', (route) => false);
                  },
                  icon: const Icon(Icons.home))
            ],
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
                    //size: Size(videoWidth!, videoHigh!),
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

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('##size = $size');
    print('## videoHigh = > $videoHigh screenHigh = $screenHigh');
    print('## videoWidth = > $videoWidth screenWidth = $screenWidth');

    double y1GreensVideoBoderSize = (size.height * 0.135);
    double x1LeftsVideoBoderSize = (size.width * 0.015);
    double x2RightsVideoBoderSize = (size.width * 0.985);
    double y2RedsVideoBoderSize = (size.height * 0.8636);

    y2Reds = y2RedsVideoBoderSize * 0.9;
    y1Greens = y2Reds! - 150;
    x1Lefts = size.width * 0.2;
    x2Rights = size.width * 0.8;

    // print('## y2Reds = $y2Reds');
    // print('## y11Greens = $y1Greens');

    // Red Reference
    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;

    Offset startingOffset = Offset(size.width * 0.2, y2Reds!);

    Offset endingOffset = Offset(size.width * 0.8, y2Reds!);

    canvas.drawLine(startingOffset, endingOffset, paint);

    // Paint paint11 = Paint();
    // paint.color = const Color.fromARGB(255, 226, 19, 64);
    // paint.strokeWidth = 1;
    // paint.strokeCap = StrokeCap.round;
    // Offset startingOffset11 =
    //     Offset(size.width * 0.2, size.height * 0.75 * 0.985 * 0.985);
    // Offset endingOffset11 =
    //     Offset(size.width * 0.80, size.height * 0.75 * 0.985 * 0.985);
    // canvas.drawLine(startingOffset11, endingOffset11, paint11);

    // Green Reference
    Paint paint2 = Paint();
    paint2.color = const Color.fromARGB(255, 13, 132, 29);
    paint2.strokeWidth = 5;
    paint2.strokeCap = StrokeCap.round;

    Offset startingOffset2 = Offset(size.width * 0.3, y1Greens!);

    Offset endingOffset2 = Offset(size.width * 0.7, y1Greens!);
    canvas.drawLine(startingOffset2, endingOffset2, paint2);

    // Paint paint21 = Paint();
    // paint2.color = const Color.fromARGB(255, 13, 132, 29);
    // paint2.strokeWidth = 1;
    // paint2.strokeCap = StrokeCap.round;
    // Offset startingOffset21 =
    //     Offset(size.width * 0.3, size.height * 0.55 * 0.985 * 0.985);
    // Offset endingOffset21 =
    //     Offset(size.width * 0.70, size.height * 0.55 * 0.985 * 0.985);
    // canvas.drawLine(startingOffset21, endingOffset21, paint21);

    // Yellow_left Reference
    Paint paint3 = Paint();
    paint3.color = const Color.fromARGB(255, 223, 194, 7);
    paint3.strokeWidth = 5;
    paint3.strokeCap = StrokeCap.round;
    Offset startingOffset3 = Offset(size.width * 0.3, y1Greens!);
    Offset endingOffset3 = Offset(size.width * 0.2, y2Reds!);
    canvas.drawLine(startingOffset3, endingOffset3, paint3);

    // Yellow_Right Reference
    Paint paint4 = Paint();
    paint4.color = const Color.fromARGB(255, 223, 194, 7);
    paint4.strokeWidth = 5;
    paint4.strokeCap = StrokeCap.round;
    Offset startingOffset4 = Offset(size.width * 0.7, y1Greens!);
    Offset endingOffset4 = Offset(size.width * 0.8, y2Reds!);
    canvas.drawLine(startingOffset4, endingOffset4, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
