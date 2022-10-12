import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flowdetect/screens/hii_station_result.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

List<dynamic> resultsList = [];

class HiiStationSecondPreview extends StatefulWidget {
  final int? postgresids;
  final String? videoNames;
  final int? y1Green;
  final int? y2Red;
  final int? x1Left;
  final int? x2Right;
  final int? thresholdvalues;
  final double? particleSizes;

  const HiiStationSecondPreview({
    Key? key,
    this.postgresids,
    this.videoNames,
    this.y1Green,
    this.y2Red,
    this.x1Left,
    this.x2Right,
    this.thresholdvalues,
    this.particleSizes,
  }) : super(key: key);

  @override
  State<HiiStationSecondPreview> createState() =>
      _HiiStationSecondPreviewState();
}

class _HiiStationSecondPreviewState extends State<HiiStationSecondPreview> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  int? postgresIntid;
  String? videoName;
  int? y1Green;
  int? y2Red;
  int? x1Left;
  int? x2Right;
  String vidUrl = '';
  double? particleSize;
  int? thresholdvalue;

  double? surfaceVelocity;

  @override
  void initState() {
    postgresIntid = widget.postgresids;
    videoName = widget.videoNames!;
    y1Green = widget.y1Green;
    y2Red = widget.y2Red;
    x1Left = widget.x1Left;
    x2Right = widget.x2Right;
    particleSize = widget.particleSizes;
    thresholdvalue = widget.thresholdvalues;
    vidUrl =
        'http://113.53.253.55:5001/static/data/hiistations/output_output_$videoName.mp4';

    // print('#### videoName = $videoName');
    // print('#### postgresIntid = $postgresIntid');
    // print('#### y1Green = $y1Green');
    // print('#### y2Red = $y2Red');
    // print('#### x1Left = $x1Left');
    // print('#### x2Right = $x2Right');
    // print('#### vid_url = $vidUrl');

    // videoPlayerController = VideoPlayerController.network(vidUrl!)
    //   ..initialize();
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController!,
    //   autoPlay: true,
    //   aspectRatio: 2 / 3,
    //   // aspectRatio: 9 / 16,
    //   // looping: true,
    // );
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
    final ProgressDialog pr = ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await pr.show();

              Map<String, dynamic> map = {};
              map['id'] = postgresIntid;
              map['thresholdvalue'] = thresholdvalue;
              map['y1Greens'] = y1Green;
              map['y2Reds'] = y2Red;
              map['videoName'] = videoName;
              map['x1Lefts'] = x1Left;
              map['x2Rights'] = x2Right;
              map['particleSize'] = particleSize;

              FormData formData = FormData.fromMap(map);

              String path =
                  'http://113.53.253.55:5001/surface_velocity_calcutated';

              await Dio().post(path, data: formData).then((value) async {
                //print(value.data);
                //resultsList = value.data;
                Map responseBody = value.data;
                //print(responseBody["surfaceVelocity"]);

                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return HiiStationResult(
                    surfaceVelocitys: responseBody["surfaceVelocity"],
                    averageVelocitys: responseBody["averageVelocyty"],
                    flowrates: responseBody["flowrate"],
                    postgresids: postgresIntid,
                  );
                }), (route) => false);
              });

              Future.delayed(const Duration(seconds: 4))
                  .then((value) async => await pr.hide());
            },
            icon: const Icon(Icons.cloud_upload_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/userService', (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
        title: const Text('Final Preview'),
      ),
      // body: FutureBuilder(
      //   builder: (context, state) => SizedBox(
      //     child: Chewie(controller: chewieController!),
      //   ),
      // ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: BetterPlayer.network(
            vidUrl,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 2 / 3,
            ),
          ),
        ),
      ),
    );
  }
}
