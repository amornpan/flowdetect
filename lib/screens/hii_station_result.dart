import 'package:flutter/material.dart';

class HiiStationResult extends StatefulWidget {
  const HiiStationResult({Key? key}) : super(key: key);

  @override
  State<HiiStationResult> createState() => _HiiStationResultState();
}

class _HiiStationResultState extends State<HiiStationResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
    );
  }
}
