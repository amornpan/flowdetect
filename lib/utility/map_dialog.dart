import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> mapDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
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
        subtitle: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xff0064b7),
          ),
        ),
      ),
      children: [
        TextButton(
          onPressed: () async {
            //Navigator.pop(context);
            await Geolocator.openLocationSettings();
            exit(0);
          },
          child: const Text('OK'),
        )
      ],
    ),
  );
}
