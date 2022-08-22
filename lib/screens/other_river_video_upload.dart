// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, prefer_const_constructors
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flowdetect/models/other_river_model.dart';
import 'package:flowdetect/utility/main_style.dart';
import 'package:flowdetect/utility/sqlite_management.dart';
import 'package:flowdetect/screens/other_river_video_player.dart';

late String videoPath;

class OtherRiverVideoUpload extends StatefulWidget {
  final String? videoPath;
  final String? pathStorage;

  const OtherRiverVideoUpload({
    Key? key,
    this.videoPath,
    this.pathStorage,
  }) : super(key: key);

  @override
  State<OtherRiverVideoUpload> createState() => _OtherRiverVideoUploadState();
}

class _OtherRiverVideoUploadState extends State<OtherRiverVideoUpload> {
  String? pathRecordVideo;
  bool load = true;
  var otherRiverModels = <OtherRiverModel>[];

  String? videoPath, pathStroage;

  Future<void> processSaveSqlite() async {
    DateTime dateTime = DateTime.now();

    OtherRiverModel otherRiverModel = OtherRiverModel(
      bVal: 0.0,
      yVal: 0.0,
      aVal: 0.0,
      otherRiverparticleSize: 0.0,
      otherRiverrecordDataTime: dateTime.toString(),
      otherRiverdevicePathStorage: pathRecordVideo!,
      otherRiversurfaceVelocity: 0.0,
      otherRiveraverageVelocity: 0.0,
      otherRiverflowrate: 0.0,
      otherRiverflagStatus: 0,
    );

    await SQLiteManagement().insertOtherRiver(otherRiverModel).then((value) {
      print('##13july processSaveSqlite Success');
      processReadAllData();
    });
  }

  Future<void> processReadAllData() async {
    if (otherRiverModels.isNotEmpty) {
      otherRiverModels.clear();
    }

    await SQLiteManagement().readOtherRiver().then((value) {
      otherRiverModels = value;
      load = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    videoPath = widget.videoPath;
    pathStroage = widget.pathStorage;
    var strings = videoPath!.split('/');
    pathRecordVideo = '$pathStroage/${strings.last}';
    processSaveSqlite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              print('icon click');
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
        title: const Text('Video Upload'),
      ),
      body: load
          ? MainStyle().showProgressBar()
          : ListView(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'No.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'DateTime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Chanel',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: otherRiverModels.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              otherRiverModels[index].idOther.toString(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(otherRiverModels[index].otherRiverrecordDataTime),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(otherRiverModels[index].otherRiverdevicePathStorage),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () async {
                                String pathVideoUpload =
                                    otherRiverModels[index].otherRiverdevicePathStorage;

                                print(
                                    '##13july pathVideoUpload ===> $pathVideoUpload');

                                File file = File(pathVideoUpload);
                                var strings = file.path.split('/');
                                String nameImage = strings.last;

                                Map<String, dynamic> map = {};
                                map['file'] = await MultipartFile.fromFile(
                                  file.path,
                                  filename: nameImage,
                                );
                                map['particle_diamiter'] = 1;

                                FormData formData = FormData.fromMap(map);
                                String path =
                                    'http://113.53.253.55:5001/upload_test_api';
                                await Dio()
                                    .post(
                                  path,
                                  data: formData,
                                )
                                    .then((value) {
                                  print('##13july value from api ==> $value');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtherRiverShowVideoPlayer(
                                            urlVideo: value.toString()),
                                      ));
                                }).catchError((error) {
                                  print('##13july error from api ==> $error');
                                });
                              },
                              icon: const Icon(Icons.cloud_upload),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () async {
                                await SQLiteManagement()
                                    .deleteOtherRiverWhereId(
                                        idOtherDelete: otherRiverModels[index].idOther!)
                                    .then((value) {
                                  processReadAllData();
                                });
                              },
                              icon: const Icon(Icons.delete_forever),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
