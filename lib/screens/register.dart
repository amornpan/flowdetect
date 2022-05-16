import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late String nameString, emailString, passwordString;

  // Method
  Widget menuButton() {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.menu));
  }

  Widget nameText() {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 17.0),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person,
          color: Color.fromARGB(255, 69, 68, 68),
          size: 20.0,
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: 'ชื่อ - นามสกุล:',
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 156, 146, 146),
            fontSize: 17.0,
            fontWeight: FontWeight.normal),
        // helperText: 'กรอกข้อมูลเป็นตัวอักษรเท่านั้น!',
        // helperStyle: const TextStyle(
        //     color: Color.fromRGBO(41, 168, 223, 1),
        //     fontStyle: FontStyle.italic),
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
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 17.0),
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          prefixIcon: const Icon(
            Icons.email,
            color: Color.fromARGB(255, 69, 68, 68),
            size: 20.0,
          ),
          labelText: 'อีเมลแอดเดรส:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 17.0,
              fontWeight: FontWeight.normal),
          // helperText: 'กรอกข้อมูลอีเมลของคุณ',
          // helperStyle: const TextStyle(
          //     color: Color.fromRGBO(41, 168, 223, 1),
          //     fontStyle: FontStyle.italic)
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
    );
  }

  Widget passwordText() {
    return TextFormField(
      autofocus: false,
      obscureText: _isObscure,
      style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 17.0),
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
          labelText: 'กำหนดรหัสผ่านมากกว่า 8 ตัวอักษร:',
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 156, 146, 146),
              fontSize: 17.0,
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
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        //debugPrint('You click Sign in botton');
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          debugPrint(
              'name = $nameString, email = $emailString, password = $passwordString');
          registerThread();
        }
      },
      child: const Text("ตกลง"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          shadowColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          primary: const Color.fromRGBO(41, 168, 223, 1),
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 21.0,
            fontFamily: "Orbitron",
          )),
    );
  }

  Future<void> registerThread() async {
    await Firebase.initializeApp().then((value) {
      debugPrint('############# connection to firebae success #############');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          actions: [menuButton()],
          backgroundColor: const Color.fromRGBO(41, 168, 223, 1),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(40.0),
              children: [
                nameText(),
                const SizedBox(height: 10),
                emailText(),
                const SizedBox(height: 10),
                passwordText(),
                const SizedBox(height: 30),
                submitButton()
              ],
            )));
  }
}
