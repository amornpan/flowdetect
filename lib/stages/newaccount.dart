import 'package:flutter/material.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({Key? key}) : super(key: key);

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  // Explicit

  late double screenWidth;
  late double screenHigh;

  bool _isObscure = true;

  late String nameString;
  late String emailString;
  late String passwordString;

  Widget nameText() {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: TextInputType.name,
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
            Icons.person,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'ชื่อ-นามสกุล:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'กรุณาป้อนชื่อ-นามสกุล';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          nameString = value!.trim();
        },
      ),
    );
  }

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
        validator: (value) {
          if (!((value!.contains('@')) && (value.contains('.')))) {
            return 'กรุณากรอกรูปแบบอีเมลให้ถูกต้อง';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          emailString = value!.trim();
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
          labelText: 'รหัสผ่านอย่างน้อย 8 ตัวอักษร:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
          // helperText: 'กรอกข้อมูลรหัสผ่านของคุณ',
          // helperStyle: const TextStyle(
          //     color: Color.fromRGBO(41, 168, 223, 1),
          //     fontStyle: FontStyle.italic)
        ),
        validator: (value) {
          if (value!.length < 8) {
            return 'กรุณากรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          passwordString = value!.trim();
        },
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        //debugPrint('You click Sign in botton');
        // if (_formKey.currentState!.validate()) {
        //   _formKey.currentState!.save();
        //   debugPrint(
        //       'name = $nameString, email = $emailString, password = $passwordString');
        //   //registerThread();
        // }
        debugPrint(
            'name = $nameString!.lenght, email = $emailString!.lenght, password = $passwordString!.lenght');
      },
      child: const Text("ตกลง"),
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameText(),
                const SizedBox(height: 10),
                emailText(),
                const SizedBox(height: 10),
                passwordText(),
                const SizedBox(height: 30),
                submitButton()
              ],
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
