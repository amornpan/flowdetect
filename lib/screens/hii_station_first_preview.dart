import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flowdetect/screens/hii_station_video_setting.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HiiStationFirstPreview extends StatefulWidget {
  final int? postgresids;
  final String? urlVideos;

  const HiiStationFirstPreview({Key? key, this.postgresids, this.urlVideos})
      : super(key: key);

  @override
  State<HiiStationFirstPreview> createState() => _HiiStationFirstPreviewState();
}

class _HiiStationFirstPreviewState extends State<HiiStationFirstPreview> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  int? postgresIntid;

  String urlVideo = "";

  Future<void> getUrlResult(int postgresIntid) async {
    Map<String, dynamic> map = {};

    map['id'] = postgresIntid;

    FormData formData = FormData.fromMap(map);
    String path =
        'http://113.53.253.55:5001/hiistations_api_calculate_distance_first';
    await Dio()
        .post(
      path,
      data: formData,
    )
        .then(
      (value) {
        print('##13july value from api ==> $value');
        urlVideo = value.toString();
      },
    ).catchError(
      (error) {
        // print('##13july error from api ==> $error');
      },
    );
  }

  @override
  void initState() {
    postgresIntid = widget.postgresids;
    urlVideo = widget.urlVideos!;
    debugPrint('### $postgresIntid');

    //getUrlResult(postgresIntid!);

    videoPlayerController = VideoPlayerController.network(urlVideo)
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      aspectRatio: 2 / 3,
      // aspectRatio: 9 / 16,
      // looping: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
    chewieController!.dispose();
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HiiStationVideoSetting()));
            },
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
        title: const Text('First Preview'),
      ),
      body: FutureBuilder(
        builder: (context, state) => SizedBox(
          // width: constraints.maxWidth,
          // height: constraints.maxHeight,
          child: Chewie(controller: chewieController!),
        ),
      ),
    );
  }
}
