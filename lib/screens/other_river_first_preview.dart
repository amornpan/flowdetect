import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'other_river_video_setting.dart';

class OtherRiverFirstPreview extends StatefulWidget {
  final int? postgresids;
  final String? videoNames;
  final int? y1Green;
  final int? y2Red;
  final int? x1Left;
  final int? x2Right;
  final double? particleSizes;

  final double? aValues;

  const OtherRiverFirstPreview({
    Key? key,
    this.postgresids,
    this.videoNames,
    this.y1Green,
    this.y2Red,
    this.x1Left,
    this.x2Right,
    this.particleSizes,
    this.aValues,
  }) : super(key: key);
  @override
  State<OtherRiverFirstPreview> createState() => _OtherRiverFirstPreviewState();
}

class _OtherRiverFirstPreviewState extends State<OtherRiverFirstPreview> {
  int? postgresIntid;
  int? y1Green;
  int? y2Red;
  int? x1Left;
  int? x2Right;
  String? videoName;
  double? particleSize;
  String vidUrl = '';
  double? aValue;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
    videoName = widget.videoNames!;
    y1Green = widget.y1Green;
    y2Red = widget.y2Red;
    x1Left = widget.x1Left;
    x2Right = widget.x2Right;
    particleSize = widget.particleSizes;
    vidUrl =
        'http://113.53.253.55:5001/static/data/otherriver/output_$videoName.mp4';
    aValue = widget.aValues;
  }

  @override
  void dispose() {
    super.dispose();
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
                    builder: (context) => OtherRiverVideoSetting(
                      imgPreviews:
                          'http://113.53.253.55:5001/static/data/otherriver/output_' +
                              videoName! +
                              '.jpg',
                      videoNames: videoName,
                      y1Green: y1Green!.toInt(),
                      y2Red: y2Red!.toInt(),
                      x1Left: x1Left!.toInt(),
                      x2Right: x2Right!.toInt(),
                      postgresids: postgresIntid,
                      particleSizes: particleSize,
                      aValues : aValue,
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
        title:  Text('First Preview $aValue'),
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
