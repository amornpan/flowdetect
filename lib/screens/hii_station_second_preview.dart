import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HiiStationSecondPreview extends StatefulWidget {
  final int? postgresids;
  final String? videoNames;
  final int? y1Green;
  final int? y2Red;
  final int? x1Left;
  final int? x2Right;

  const HiiStationSecondPreview({
    Key? key,
    this.postgresids,
    this.videoNames,
    this.y1Green,
    this.y2Red,
    this.x1Left,
    this.x2Right,
  }) : super(key: key);

  @override
  State<HiiStationSecondPreview> createState() =>
      _HiiStationSecondPreviewState();
}

class _HiiStationSecondPreviewState extends State<HiiStationSecondPreview> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  int? postgresIntid;
  String videoName = "";
  int? y1Green;
  int? y2Red;
  int? x1Left;
  int? x2Right;

  @override
  void initState() {
    postgresIntid = widget.postgresids;
    videoName = widget.videoNames!;
    y1Green = widget.y1Green;
    y2Red = widget.y2Red;
    x1Left = widget.x1Left;
    x2Right = widget.x2Right;

    print('#### videoName = $videoName');
    print('#### postgresIntid = $postgresIntid');
    print('#### y1Green = $y1Green');
    print('#### y2Red = $y2Red');
    print('#### x1Left = $x1Left');
    print('#### x2Right = $x2Right');

    var vid_url =
        'http://113.53.253.55:5001/static/data/hiistations/$videoName.mp4';

    print('#### vid_url = $vid_url');

    videoPlayerController = VideoPlayerController.network(vid_url)
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
        title: const Text('Final Result'),
      ),
      body: FutureBuilder(
        builder: (context, state) => SizedBox(
          child: Chewie(controller: chewieController!),
        ),
      ),
    );
  }
}
