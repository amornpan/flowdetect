// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, prefer_const_constructors
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flowdetect/models/sqlite_model.dart';
import 'package:flowdetect/utility/main_style.dart';
import 'package:flowdetect/utility/sqlite_helper.dart';
import 'package:flowdetect/screens/show_video_player.dart';
import 'package:intl/intl.dart';

late String videoPath;
//List<Measurement> measurements = getInfo();

class VideoUpload extends StatefulWidget {
  final String? videoPath;
  final String? pathStorage;
  final int? postgresids;

  const VideoUpload({
    Key? key,
    this.videoPath,
    this.pathStorage,
    this.postgresids,
  }) : super(key: key);

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  String? pathRecordVideo;
  bool load = true;
  var sqliteModels = <SQLiteModel>[];

  String? videoPath;
  String? pathStorage;
  int? postgresIntid;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
    print('## postgresid Video Upload Page= $postgresIntid');

    videoPath = widget.videoPath;
    pathStorage = widget.pathStorage;
    var strings = videoPath!.split('/');
    pathRecordVideo = '$pathStorage/${strings.last}';
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
              await SQLiteHelper().deleteAll().then((value) {
                processSaveSqlite();
              });
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
                            'Station',
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
                  itemCount: sqliteModels.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              sqliteModels[index].id.toString(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(sqliteModels[index].recordDataTime),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(sqliteModels[index].station),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () async {
                                String pathVideoUpload =
                                    sqliteModels[index].pathStorage;

                                print(
                                    '##13july pathVideoUpload ===> $pathVideoUpload');

                                File file = File(pathVideoUpload);
                                var strings = file.path.split('/');
                                String nameVideo = strings.last;

                                Map<String, dynamic> map = {};
                                map['file'] = await MultipartFile.fromFile(
                                  file.path,
                                  filename: nameVideo,
                                );
                                map['updateid'] = postgresIntid;
                                map['devicePathStorage'] =
                                    pathStorage! + "/" + nameVideo;

                                FormData formData = FormData.fromMap(map);
                                String path =
                                    'http://113.53.253.55:5001/hiistations_api';
                                await Dio()
                                    .post(
                                  path,
                                  data: formData,
                                )
                                    .then(
                                  (value) {
                                    print('##13july value from api ==> $value');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowVideoPlayer(
                                            urlVideo: value.toString()),
                                      ),
                                    );
                                  },
                                ).catchError(
                                  (error) {
                                    print('##13july error from api ==> $error');
                                  },
                                );
                              },
                              icon: const Icon(Icons.cloud_upload),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () async {
                                await SQLiteHelper()
                                    .deleteWhereId(
                                        idDelete: sqliteModels[index].id!)
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

  Future<void> processSaveSqlite() async {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(dateTime);

    SQLiteModel sqLiteModel = SQLiteModel(
        recordDataTime: formattedDate,
        station: 'station',
        pathStorage: pathRecordVideo!);

    await SQLiteHelper().insertData(sqLiteModel: sqLiteModel).then((value) {
      print('##13july processSaveSqlite Success');
      processReadAllData();
    });
  }

  Future<void> processReadAllData() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readAllData().then((value) {
      sqliteModels = value;
      load = false;
      setState(() {});
    });
  }
}
