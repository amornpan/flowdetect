import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiiStationWebview extends StatefulWidget {
  final int? postgresids;
  final String? urlVideos;

  const HiiStationWebview({Key? key, this.postgresids, this.urlVideos})
      : super(key: key);

  @override
  State<HiiStationWebview> createState() => _HiiStationWebviewState();
}

class _HiiStationWebviewState extends State<HiiStationWebview> {
  int? postgresIntid;
 String? urlVideo;

  // Future<void> getUrlResult(int postgresIntid) async {
  //   Map<String, dynamic> map = {};

  //   map['id'] = postgresIntid;

  //   FormData formData = FormData.fromMap(map);
  //   String path =
  //       'http://113.53.253.55:5001/hiistations_api_calculate_distance_first';
  //   await Dio()
  //       .post(
  //     path,
  //     data: formData,
  //   )
  //       .then(
  //     (value) {
  //       print('##13july value from api ==> $value');
  //       urlVideo = value.toString();

  //       print('1urlVideo $urlVideo');
  //     },
  //   ).catchError(
  //     (error) {
  //       // print('##13july error from api ==> $error');
  //     },
  //   );
  // }

  @override
  void initState() {
    postgresIntid = widget.postgresids;
    urlVideo = widget.urlVideos;
    //getUrlResult(postgresIntid!);
    print('2urlVideo $urlVideo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.looks_one_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/userService', (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
        title: const Text('Display Output'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('urlVideo = $urlVideo'),
              WebView(
                // initialUrl:
                //     'http://113.53.253.55:5001/static/data/hiistations/output_REC-859756914.mp4',
                initialUrl: urlVideo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
