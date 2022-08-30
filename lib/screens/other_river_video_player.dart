import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OtherRiverShowVideoPlayer extends StatefulWidget {
  final String urlVideo;
  const OtherRiverShowVideoPlayer({
    Key? key,
    required this.urlVideo,
  }) : super(key: key);

  @override
  State<OtherRiverShowVideoPlayer> createState() =>
      _OtherRiverShowVideoPlayerState();
}

class _OtherRiverShowVideoPlayerState extends State<OtherRiverShowVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  String? urlVideo;

  @override
  void initState() {
    super.initState();

    urlVideo = widget.urlVideo;

    videoPlayerController = VideoPlayerController.network(urlVideo!)
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      aspectRatio: 2 / 3,
      // looping: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/userService',
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home))
          ],
          title: const Text('Display Output Other River'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Chewie(controller: chewieController!),
          ),
        ),
      ),
    );
  }
}
