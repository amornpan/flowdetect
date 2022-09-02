import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flowdetect/screens/hii_station_first_preview.dart';
import 'package:flowdetect/screens/hii_video_upload.dart';
import 'package:flowdetect/screens/show_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

import '../utility/main_style.dart';
import 'hii_station_result.dart';

String? videoPath;

class VideoPage extends StatefulWidget {
  final String filePath;
  final int? postgresids;
  final double? y1Greens;
  final double? y2Reds;
  final double? x1Lefts;
  final double? x2Rights;

  const VideoPage({
    Key? key,
    required this.filePath,
    required this.postgresids,
    required this.y1Greens,
    required this.y2Reds,
    required this.x1Lefts,
    required this.x2Rights,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  String? pathStorage;
  int? postgresIntid;
  double? y1Green;
  double? y2Red;
  double? x1Left;
  double? x2Right;

  @override
  void initState() {
    postgresIntid = widget.postgresids;

    y1Green = widget.y1Greens;
    y2Red = widget.y2Reds;
    x1Left = widget.x1Lefts;
    x2Right = widget.x2Rights;

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
                      // aspectRatio: videoaspectRatio!,
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   'Video Path:' + videoPath.toString(),
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 10.0,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FloatingActionButton.extended(
                            heroTag: "Undo Button",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.undo),
                            label: const Text('Undo'),
                          ),
                        ),
                        // const SizedBox(width: 10),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: FloatingActionButton.extended(
                        //     heroTag: "Save Button",
                        //     onPressed: () async {
                        //       debugPrint('##10aug save Video at $videoPath');
                        //       await GallerySaver.saveVideo(videoPath.toString())
                        //           .then((value) {
                        //         debugPrint(
                        //             '##10aug value.tostring ${value.toString()}');
                        //         dispose();
                        //       });
                        //       File(videoPath.toString()).deleteSync();
                        //       // Navigator.pushNamed(
                        //       //   context,
                        //       //   '/videoUpload',
                        //       //   arguments: <String, dynamic>{
                        //       //     'videoPath': videoPath,
                        //       //     'pathStorage' : pathStorage,
                        //       //   },
                        //       // );
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => VideoUpload(
                        //               videoPath: videoPath,
                        //               pathStorage: pathStorage,
                        //               postgresids: postgresIntid,
                        //             ),
                        //           ));
                        //     },
                        //     icon: const Icon(Icons.save),
                        //     label: const Text('Save'),
                        //   ),
                        // ),
                        const SizedBox(width: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.extended(
                            heroTag: "Cloud Button",
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
                              map['updateid'] = postgresIntid;
                              map['devicePathStorage'] =
                                  pathStorage! + "/" + nameVideo;
                              map['y1greens'] = y1Green;
                              map['y2reds'] = y2Red;
                              map['x1lefts'] = x1Left;
                              map['x2rights'] = x2Right;
                              map['outputpath'] = nameVideo;

                              FormData formData = FormData.fromMap(map);
                              String path =
                                  'http://113.53.253.55:5001/hiistations_api';

                              await Dio().post(path, data: formData).then(
                                (value) {
                                  //print('##10aug value from api =.=> $value');
                                  if (value != null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "บันทึกข้อมูลเรียบร้อย"),
                                          actions: <Widget>[
                                            OutlinedButton(
                                              child: const Text("ถัดไป"),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HiiStationFirstPreview(
                                                      postgresids:
                                                          postgresIntid,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    MainStyle().showProgressBar();
                                  }
                                },
                              ).catchError(
                                (error) {
                                  print('##10aug error $error');
                                },
                              );
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
