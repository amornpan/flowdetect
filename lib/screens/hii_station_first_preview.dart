import 'package:chewie/chewie.dart';
import 'package:flowdetect/screens/hii_station_video_setting.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

class HiiStationFirstPreview extends StatefulWidget {
  final int? postgresids;
  final String? videoNames;
  final int? y1Green;
  final int? y2Red;
  final int? x1Left;
  final int? x2Right;

  const HiiStationFirstPreview({
    Key? key,
    this.postgresids,
    this.videoNames,
    this.y1Green,
    this.y2Red,
    this.x1Left,
    this.x2Right,
  }) : super(key: key);

  @override
  State<HiiStationFirstPreview> createState() => _HiiStationFirstPreviewState();
}

class _HiiStationFirstPreviewState extends State<HiiStationFirstPreview> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

 // late VideoPlayerController _controller;

  int? postgresIntid;
  int? y1Green;
  int? y2Red;
  int? x1Left;
  int? x2Right;
  String? videoName;

  String vidUrl = '';

  @override
  void initState() {
    //getUrlResult(postgresIntid!);

    postgresIntid = widget.postgresids;
    videoName = widget.videoNames!;
    y1Green = widget.y1Green;
    y2Red = widget.y2Red;
    x1Left = widget.x1Left;
    x2Right = widget.x2Right;
    vidUrl =
        'http://113.53.253.55:5001/static/data/hiistations/output_$videoName.mp4';

    // _controller = VideoPlayerController.network(vidUrl)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    // print('### 11 vidUrl $vidUrl');

    // videoPlayerController = VideoPlayerController.network(vidUrl)..initialize();
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
    //videoPlayerController!.dispose();
    //chewieController!.dispose();
    //_controller.dispose();
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

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HiiStationVideoSetting(
                      imgPreviews:
                          'http://113.53.253.55:5001/static/data/hiistations/output_' +
                              videoName! +
                              '.jpg',
                      videoNames: videoName,
                      y1Green: y1Green!.toInt(),
                      y2Red: y2Red!.toInt(),
                      x1Left: x1Left!.toInt(),
                      x2Right: x2Right!.toInt(),
                      postgresids: postgresIntid,
                    ),
                  ),
                  (route) => false);

              Future.delayed(const Duration(seconds: 4))
                  .then((value) async => await pr.hide());
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
      // body: FutureBuilder(
      //   builder: (context, state) => SizedBox(
      //     child: Chewie(controller: chewieController!),
      //   ),
      // ),
      // body: _controller.value.isInitialized
      //         ? AspectRatio(
      //             aspectRatio: _controller.value.aspectRatio,
      //             child: VideoPlayer(_controller),
      //           )
      //         : Container(),

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
