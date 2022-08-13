// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoPlayer extends StatefulWidget {
  final String urlVideo;
  const ShowVideoPlayer({
    Key? key,
    required this.urlVideo,
  }) : super(key: key);

  @override
  State<ShowVideoPlayer> createState() => _ShowVideoPlayerState();
}

class _ShowVideoPlayerState extends State<ShowVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  String? urlVideo;

  @override
  void initState() {
    super.initState();
    fetchData();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      aspectRatio: 2 / 3,
      looping: false,
    );
  }

  Future fetchData() async {
    urlVideo = widget.urlVideo;
    debugPrint(urlVideo);
    videoPlayerController = VideoPlayerController.network(urlVideo!);
    await videoPlayerController!.initialize();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/userService', (route) => false);
              },
              icon: const Icon(Icons.home))
        ],
        title: const Text('Show Video Player'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Chewie(controller: chewieController!),
        ),
      ),
      // Text(urlVideo!)
    );
  }
}
