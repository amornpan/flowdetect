import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utility/dialog.dart';
import '../utility/main_style.dart';
import 'show_video_player.dart';

double? distance;
double? surfaceVelocity;
double? averageVelocity;
double? flowrate;

class HiiStationResult extends StatefulWidget {
  final int? postgresids;

  const HiiStationResult({Key? key, this.postgresids}) : super(key: key);

  @override
  State<HiiStationResult> createState() => _HiiStationResultState();
}

class _HiiStationResultState extends State<HiiStationResult> {
  int? postgresIntid;
  String? urlVideo;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
  }

  Future<void> getResult() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/userService', (route) => false);
              },
              icon: const Icon(Icons.home))
        ],
        title: const Text('Display Output'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          //child:Image.asset('images/underconstruction.png'),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ผลลัพธ์การคำนวน',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff0064b7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ระยะทาง : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        distance == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$distance',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    )
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distance = 120;
                    });
                  },
                  child: const Text('คำนวณค่าระยะทาง'),
                ),
                const SizedBox(height: 20),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ความเร็วบนผิวน้ำ : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        distance == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$surfaceVelocity',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ความเร็วหน้าตัด : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        distance == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$averageVelocity',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'อัตราการไหล : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        distance == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$flowrate',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (distance == null) {
                      normalDialog(context, "ยังไม่ได้คำนวณระยะทาง",
                          "กรุณากดคำนวณระยะทางก่อน!!");
                    } else {}
                  },
                  child: const Text('คำนวณค่าความเร็วและอัตราการไหล'),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> map = {};
                    map['id'] = postgresIntid;
                    FormData formData = FormData.fromMap(map);
                    String path =
                        'http://113.53.253.55:5001/hiistations_api_calculate';
                    await Dio().post(path, data: formData).then(
                      (value) {
                        if (value != null) {
                          urlVideo = value.toString();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ShowVideoPlayer(
                                  urlVideo: urlVideo!,
                                );
                              },
                            ),
                          );
                        }
                      },
                    ).catchError(
                      (error) {
                        print('##10aug error $error');
                      },
                    );
                  },
                  child: const Text('เล่นไฟล์วีดีโอ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
