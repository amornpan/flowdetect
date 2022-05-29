import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';

Future<void> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: MainStyle().showLogo(),
        title: Text(
          title,
          style: MainStyle().darkStyle(),
        ),
        subtitle: Text(message),
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
