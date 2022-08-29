import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flowdetect/screens/hii_video_upload.dart';
import 'package:flowdetect/screens/show_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

String? videoPath;

class VideoPage extends StatefulWidget {
  final String filePath;
  final int? postgresids;

  const VideoPage({
    Key? key,
    required this.filePath,
    required this.postgresids,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  String? pathStorage;

  int? postgresIntid;

  @override
  void initState() {
    postgresIntid = widget.postgresids;
    print('## postgresid Video Page= $postgresIntid');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Future _initVideoPlayer() async {
    videoPath = widget.filePath;
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    findPathStorage();
  }

  Future<void> findPathStorage() async {
    pathStorage = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_MOVIES);
    debugPrint('###11aug $pathStorage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'แสดงผลการบันทึกไฟล์วีดีโอ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade500,
        //actions: [IconButton(icon: const Icon(Icons.check), onPressed: () {})]
      ),
      //extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _initVideoPlayer(),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      child: VideoPlayer(_videoPlayerController),
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Video Path:' + videoPath.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FloatingActionButton.extended(
                            heroTag: "btnUndo",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.undo),
                            label: const Text('Undo'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton.extended(
                            heroTag: "btnSave",
                            onPressed: () async {
                              debugPrint('##10aug save Video at $videoPath');
                              await GallerySaver.saveVideo(videoPath.toString())
                                  .then((value) {
                                debugPrint(
                                    '##10aug value.tostring ${value.toString()}');
                                dispose();
                              });
                              File(videoPath.toString()).deleteSync();
                              // Navigator.pushNamed(
                              //   context,
                              //   '/videoUpload',
                              //   arguments: <String, dynamic>{
                              //     'videoPath': videoPath,
                              //     'pathStorage' : pathStorage,
                              //   },
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoUpload(
                                      videoPath: videoPath,
                                      pathStorage: pathStorage,
                                      postgresids: postgresIntid,
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Save'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.extended(
                            heroTag: "btnCloud",
                            onPressed: () async {
                              print('##10aug Click Cloud');
                              _videoPlayerController.pause();
                              File file = File(widget.filePath);

                              var strings = file.path.split('/');
                              String nameVideo = strings.last;

                              Map<String, dynamic> map = {};
                              map['file'] = await MultipartFile.fromFile(
                                  file.path,
                                  filename: nameVideo);
                              map['particle_diamiter'] = 1;
                              FormData formData = FormData.fromMap(map);
                              String path =
                                  'http://113.53.253.55:5001/upload_test_api';
                              await Dio()
                                  .post(path, data: formData)
                                  .then((value) {
                                print('##10aug value from api =.=> $value');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowVideoPlayer(
                                          urlVideo: value.toString()),
                                    ));
                              }).catchError((error) {
                                print('##10aug error $error');
                              });
                            },
                            icon: const Icon(Icons.cloud),
                            label: const Text('Cloud'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
