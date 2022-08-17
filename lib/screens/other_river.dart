import 'package:camera/camera.dart';
import 'package:flowdetect/screens/camera_page.dart';
import 'package:flutter/material.dart';
import '../utility/dialog.dart';
import '../utility/main_style.dart';

class OtherRiver extends StatefulWidget {
  const OtherRiver({Key? key}) : super(key: key);

  @override
  State<OtherRiver> createState() => _OtherRiverState();
}

class _OtherRiverState extends State<OtherRiver> {
  late double screenWidth;
  late double screenHigh;

  String strBValue = "";
  String strYValue = "";
  String strAValue = "";

  Widget txtBValue() {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style:
            const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 16.0),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 4.0),
          ),
          prefixIcon: const Icon(
            // Icons.height,
            Icons.swap_horiz,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'ค่าตัวแปร B (ความกว้างท้องน้ำ) เมตร:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
        onChanged: (value) {
          strBValue = value.trim();
        },
      ),
    );
  }

  Widget txtYValue() {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style:
            const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 16.0),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 4.0),
          ),
          prefixIcon: const Icon(
            // Icons.height,
            Icons.swap_vert,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'ค่าตัวแปร Y (ความสูงลำน้ำ) เมตร:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
        onChanged: (value) {
          strYValue = value.trim();
        },
      ),
    );
  }

  Widget calculateAreaButton() {
    return ElevatedButton(
      onPressed: () async {
        if ((strBValue.isEmpty) || (strYValue.isEmpty)) {
          normalDialog(context, "พบค่าว่าง", "กรุณากรอกข้อมูลให้ครบ");
        } else {
          // add strBValue, strYValue, other river tag, datetime to sqlite
          // debugPrint('##17aug strBValue= $strBValue');
          // debugPrint('##17aug strYValue= $strYValue');

          setState(() {
            strAValue = areaCaluclate(strBValue, strYValue);
          });
        }
      },
      child: const Text("คำนวณ ขนาดของพื้นที่"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          shadowColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          primary: Colors.blue.shade500,
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 19.0,
            fontFamily: "Orbitron",
          )),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if ((strBValue.isEmpty) || (strYValue.isEmpty) || (strAValue.isEmpty)) {
          normalDialog(context, "พบค่าว่าง", "กรุณากรอกข้อมูลให้ครบ");
        } else {
          // redict to camerapage
          await availableCameras().then((value) => Navigator.push(context,
                  //MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                  MaterialPageRoute(builder: (_) {
                return CameraPage(
                  cameras: value,
                );
              })));
        }
      },
      child: const Text("ถัดไป"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          shadowColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          primary: Colors.blue.shade500,
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 21.0,
            fontFamily: "Orbitron",
          )),
    );
  }

  String areaCaluclate(var bval, var yval) {
    var dblBvalue = double.parse(bval);
    var dblYvalue = double.parse(yval);
    debugPrint('##17aug dblBvalue = $dblBvalue dblYvalue= $dblYvalue');
    if (dblBvalue < 0 || dblYvalue < 0) {
      return "0.0";
    } else {
      var Aval = (((dblBvalue * 2) + (dblYvalue * 6)) / 2 * dblYvalue);
      return Aval.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ตำแหน่งใดๆ บนลำน้ำ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.blue.shade500,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Colors.blue.shade500,
              child: const ClipPath(),
              height: screenHigh,
              width: screenWidth,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'กรุณาระบุค่าตัวแปร B และ Y',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff0064b7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MainStyle().showOtherRiverMeasurementImage(),
                  const SizedBox(height: 10),
                  Text('ขนาดของพื้นที่หน้าตัด (A) = ' + strAValue),
                  const SizedBox(height: 20),
                  txtBValue(),
                  const SizedBox(height: 15),
                  txtYValue(),
                  const SizedBox(height: 15),
                  calculateAreaButton(),
                  const SizedBox(height: 15),
                  submitButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
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

    // Bottom
    // path0.moveTo(0, size.height * 1.0007194);
    // path0.lineTo(0, size.height * 0.8820144);
    // path0.quadraticBezierTo(size.width * 0.1937556, size.height * 0.9706906,
    //     size.width * 0.3361111, size.height * 0.9690647);
    // path0.cubicTo(
    //     size.width * 0.4723556,
    //     size.height * 0.9600719,
    //     size.width * 0.6323556,
    //     size.height * 0.9025180,
    //     size.width * 0.7922222,
    //     size.height * 0.9043165);
    // path0.quadraticBezierTo(size.width * 0.8812444, size.height * 0.9070216,
    //     size.width, size.height * 0.9420863);
    // path0.lineTo(size.width, size.height * 1.0021583);

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
