import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flowdetect/screens/other_river_camera_page.dart';
import 'package:flowdetect/screens/other_river_video_upload.dart';
import 'package:flowdetect/screens/other_river_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

import 'other_river_first_preview.dart';

String? videoPath;

class OtherRiverVideoPage extends StatefulWidget {
  final String filePath;
  const OtherRiverVideoPage({
    Key? key,
    required this.filePath,
    this.postgresids,
    this.y1Greens,
    this.y2Reds,
    this.x1Lefts,
    this.x2Rights,
    this.particleSizes,
    this.aValues,
    this.bValues,
    this.yValues,
    this.names,
  }) : super(key: key);

  final int? postgresids;
  final String? names;
  final double? bValues;
  final double? yValues;
  final double? aValues;
  final double? particleSizes;
  final double? y1Greens;
  final double? y2Reds;
  final double? x1Lefts;
  final double? x2Rights;

  @override
  State<OtherRiverVideoPage> createState() => _OtherRiverVideoPageState();
}

class _OtherRiverVideoPageState extends State<OtherRiverVideoPage> {
  late VideoPlayerController _videoPlayerController;
  String? pathStorage;
  int? postgresIntid;
  double? y1Green;
  double? y2Red;
  double? x1Left;
  double? x2Right;
  double? particleSize;
  String? name;

  @override
  void initState() {
    super.initState();

    name = widget.names;
    bValue = widget.bValues;
    yValue = widget.yValues;
    aValue = widget.aValues;
    particleSize = widget.particleSizes;
    y1Green = widget.y1Greens;
    y2Red = widget.y2Reds;
    x1Left = widget.x1Lefts;
    x2Right = widget.x2Rights;
    postgresIntid = widget.postgresids;

    debugPrint('name $name');
    debugPrint('bValue $bValue');
    debugPrint('yValue $yValue');
    debugPrint('aValue $aValue');
    debugPrint('particleSize $particleSize');
    debugPrint('y1Green $y1Green');
    debugPrint('y2Red $y2Red');
    debugPrint('x1Left $x1Left');
    debugPrint('x2Right $x2Right');
    debugPrint('postgresIntid $postgresIntid');
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
          'ผลการบันทึกไฟล์วีดีโอ ลำน้ำใดๆ',
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
                              map['updateid'] = postgresIntid;
                              map['devicePathStorage'] =
                                  pathStorage! + "/" + nameVideo;
                              map['y1greens'] = y1Green!.toInt();
                              map['y2reds'] = y2Red!.toInt();
                              map['x1lefts'] = x1Left!.toInt();
                              map['x2rights'] = x2Right!.toInt();
                              map['outputpath'] = nameVideo;

                              FormData formData = FormData.fromMap(map);
                              String path =
                                  'http://113.53.253.55:5001/otherriver_api2';
                              await Dio()
                                  .post(path, data: formData)
                                  .then((value) {
                                print('##10aug value from api =.=> $value');

                                var videoName = value.toString();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OtherRiverFirstPreview(
                                        postgresids: postgresIntid,
                                        videoNames: videoName,
                                        y1Green: y1Green!.toInt(),
                                        y2Red: y2Red!.toInt(),
                                        x1Left: x1Left!.toInt(),
                                        x2Right: x2Right!.toInt(),
                                        particleSizes: particleSize,
                                        aValues: aValue,
                                      ),
                                    ));
                              }).catchError((error) {
                                print('##10aug error $error');
                              });
                            },
                            icon: const Icon(Icons.cloud_upload),
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
