import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class HiiStationFirstPreview extends StatefulWidget {
  final int? postgresids;

  const HiiStationFirstPreview({Key? key, this.postgresids}) : super(key: key);

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
    debugPrint('### $postgresIntid');

    getUrlResult(postgresIntid!);

    videoPlayerController = VideoPlayerController.network(urlVideo)
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      aspectRatio: 2 / 3,
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
