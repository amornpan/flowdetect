import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiiStationResult extends StatefulWidget {
  final int? postgresids;

  const HiiStationResult({Key? key, this.postgresids}) : super(key: key);

  @override
  State<HiiStationResult> createState() => _HiiStationResultState();
}

class _HiiStationResultState extends State<HiiStationResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/userService', (route) => false);
              },
              icon: const Icon(Icons.home))
        ],
        title: const Text('Display Output'),
      ),
      // body: WebView(
      //     //initialUrl: '${news['url']}',
      //   )
      body: Container(
            color: Colors.white,
            child:Center(
                child:Image.asset('images/underconstruction.png')
            ),
          ),
    );
  }
}
