import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiiStationWebview extends StatefulWidget {
  final int? postgresids;
  const HiiStationWebview({Key? key, this.postgresids}) : super(key: key);

  @override
  State<HiiStationWebview> createState() => _HiiStationWebviewState();
}

class _HiiStationWebviewState extends State<HiiStationWebview> {
  int? postgresIntid;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Webbiew'),
        ),
        body: const WebView(
          initialUrl:
              'http://113.53.253.55:5001/static/data/hiistations/output_REC-859756914.mp4',
        ));
  }
}
