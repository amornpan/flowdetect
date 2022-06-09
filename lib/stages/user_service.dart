import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';

class UserService extends StatefulWidget {
  const UserService({Key? key}) : super(key: key);

  @override
  State<UserService> createState() => _UserServiceState();
}

class _UserServiceState extends State<UserService> {
  late double screenWidth;
  late double screenHigh;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "River Flow Detect",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.blue.shade500,
        elevation: 0.0,
      ),
      drawer: Drawer(child: buildSignOut()),
      body: Stack(
        children: [
          buildImageButtion(),
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
                children: [buildImageButtion()],
              ),
            ),
          )
        ],
      ),
    );

  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: Colors.blue.shade600,
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: const Text(
            'ออกจากระบบ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'ออกจากระบบและกลับสู่หน้าแรก',
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  buildImageButtion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'กรุณาเลือกเมนูที่ต้องการทำรายการ',
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xff0064b7),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

          Column(
            children: [
              InkWell(
                onTap: (){},
                child: MainStyle().showHiiImage(),

              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'สถานีโทรมาตร\nวัดระดับน้ำ สสน.',
                  style: TextStyle(
                    fontSize:  16.0,
                    color: Color(0xff0064b7),
                    fontWeight: FontWeight.normal,               
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 30),
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: MainStyle().showOtherRiverImage(),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'ตำแหน่งใดๆ\nบนลำน้ำ',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff0064b7),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ]),
      ],
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
