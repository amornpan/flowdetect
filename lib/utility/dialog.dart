import 'package:flutter/material.dart';

Future<void> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      // title: ListTile(
      //   //leading: MainStyle().showLogo(),
      //   //leading: const Text('ข้อความแจ้งให้ทราบ!'),
      //   title: Text(
      //     title,
      //     style: MainStyle().darkStyle(),
      //   ),
      //   subtitle: Text(message),
      // ),
      title: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff0064b7),
            ),
          ),
        ),
        subtitle: Text(message,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xff0064b7),
          ),
        ),
      ),
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    ),
  );
}
