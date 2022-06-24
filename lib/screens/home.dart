import 'package:flowdetect/screens/register.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Methods

  Widget showLogo() {
    return SizedBox(
        width: 150.0, height: 150.0, child: Image.asset("images/logo.png"));
  }

  Widget showAppName() {
    return Text(
      "Flow Detect",
      style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.normal,
          color: Colors.lightBlueAccent.shade700,
          fontFamily: "Orbitron"),
    );
  }

  Widget signInButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint('You click Sign in botton');
      },
      child: const Text("Register"),
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

  Widget registerButton() {
    return OutlinedButton(
      onPressed: () {
        //print('You click Signup botton');

        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => const Register());
        Navigator.of(context).push(materialPageRoute);
      },
      child: const Text("Sign Up"),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shadowColor: Colors.black,
          elevation: 10,
          fixedSize: const Size(250, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
            fontFamily: "Orbitron",
          )),
    );
  }

  Widget showButton() {
    
     return Column(
       mainAxisSize: MainAxisSize.min,
       
       children: <Widget>[
         signInButton(),
         const SizedBox(height: 20),
         registerButton()
       ],
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showLogo(),
            const SizedBox(height: 10),
            showAppName(),
            const SizedBox(height: 120),
            showButton(),
          ],
        ),
      )),
    );
  }
}
