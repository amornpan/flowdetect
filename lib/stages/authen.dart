import 'package:flowdetect/utility/dialog.dart';
import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  late double screenWidth;
  late double screenHigh;

  String emailString = "";
  String passwordString = "";

  bool _isObscure = true;

  Widget emailText() {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
            Icons.email,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'อีเมลแอดเดรส:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
        onChanged: (value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        autofocus: false,
        obscureText: _isObscure,
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
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off)),
          prefixIcon: const Icon(
            Icons.lock,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'รหัสผ่าน:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
        onChanged: (value) {
          passwordString = value.trim();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    return Scaffold(
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHigh * 0.10),
                  MainStyle().showLogo(),
                  const SizedBox(height: 20),
                  emailText(),
                  const SizedBox(height: 10),
                  passwordText(),
                  const SizedBox(height: 10),
                  buildSignInEmail(),
                  const SizedBox(height: 10),
                  buildSignInGoogle(),
                  const SizedBox(height: 10),
                  buildSignInFacebook(),
                  const SizedBox(height: 10),
                  buildSignInApple(),
                  const SizedBox(height: 10),
                  buildNewAccount(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row buildNewAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Non Account?',
          style: MainStyle().darkStyle(),
        ),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/newAccount'),
            child: const Text(
              'Create Account',
              style: TextStyle(
                color: Color.fromARGB(255, 150, 70, 8),
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    );
  }

  SizedBox buildSignInEmail() => SizedBox(
        width: screenWidth * 0.8,
        height: 45.0,
        child: SignInButton(
          Buttons.Email,
          onPressed: () {
            if ((emailString.isEmpty) || (passwordString.isEmpty)) {
              normalDialog(context, "พบค่าว่าง", "กรุณากรอกข้อมูลให้ครบ");
              //debugPrint('ว่าง');

            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  SizedBox buildSignInGoogle() => SizedBox(
        width: screenWidth * 0.8,
        height: 45.0,
        child: SignInButton(
          Buttons.GoogleDark,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  SizedBox buildSignInFacebook() => SizedBox(
        width: screenWidth * 0.8,
        height: 45.0,
        child: SignInButton(
          Buttons.FacebookNew,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );

  SizedBox buildSignInApple() => SizedBox(
        width: screenWidth * 0.8,
        height: 45.0,
        child: SignInButton(
          Buttons.AppleDark,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
