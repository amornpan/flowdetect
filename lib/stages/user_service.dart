import 'package:flutter/material.dart';

class UserService extends StatefulWidget {
  const UserService({Key? key}) : super(key: key);

  @override
  State<UserService> createState() => _UserServiceState();
}

class _UserServiceState extends State<UserService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome User'),
      ),
    );
  }
}
