import 'package:flutter/material.dart';

class HiiStatSelectSite extends StatefulWidget {
  const HiiStatSelectSite({Key? key}) : super(key: key);

  @override
  State<HiiStatSelectSite> createState() => _HiiStatSelectSiteState();
}

class _HiiStatSelectSiteState extends State<HiiStatSelectSite> {
  late double screenWidth;
  late double screenHigh;

  final items_list = [
    'เมืองขอนแก่น (CHI006)',
    'เขื่องใน (CHI011)',
    'เมืองมหาสารคาม (CHI012)',
    'สะพานฉลองขอนแก่น 200 ปี (CHI015)',
    'เมืองสุรินทร์ (MUN009)',
    'ท่าตูม (MUN015)',
    'เมืองอุบลราชธานี (MUN017)',
    'อากาศอำนวย (SKM001)',
    'ลำน้ำอูน (TBW027)',
    'บ้านโพธิ์ชัยทอง (TBW028)'
  ];

  String dropdownValue = 'เมืองขอนแก่น (CHI006)';

  Widget dropDownStation() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Color(0xff0064b7),
      ),
      underline: Container(
        height: 2,
        color: const Color(0xff0064b7),
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: items_list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: const TextStyle(fontSize: 20.0),),
          
        );
      }).toList(),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint('You click Sign in botton');
      },
      child: const Text("ต่อไป"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          shadowColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          primary: const Color.fromRGBO(41, 168, 223, 1),
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
            fontFamily: "Orbitron",
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    //Method
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สถานีโทรมาตรวัดระดับน้ำ สสน.',
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
                    'กรุณาเลือกสถานีที่ต้องการทำรายการ',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff0064b7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  dropDownStation(),
                  const SizedBox(height: 20),
                  nextButton(),
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

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
