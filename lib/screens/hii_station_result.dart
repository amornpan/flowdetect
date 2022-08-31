import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'show_video_player.dart';

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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     returnStationCode == null
                //         ? MainStyle().showProgressBar()
                //         : Text('รหัสสถานี: $returnStationCode'),
                //     const SizedBox(width: 5),
                //     name == null
                //         ? MainStyle().showProgressBar()
                //         : Text('ชื่อสถานี: $name'),
                //     const SizedBox(height: 10),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     date == null
                //         ? MainStyle().showProgressBar()
                //         : Text('วันที่: $date'),
                //     const SizedBox(width: 5),
                //     time == null
                //         ? MainStyle().showProgressBar()
                //         : Text('เวลา: $time'),
                //     const SizedBox(height: 10),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     lat == null
                //         ? MainStyle().showProgressBar()
                //         : Text('Lat: $lat'),
                //     const SizedBox(width: 5),
                //     lng == null
                //         ? MainStyle().showProgressBar()
                //         : Text('Lng: $lng'),
                //     const SizedBox(height: 10),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     left_bank == null
                //         ? MainStyle().showProgressBar()
                //         : Text('ตลิ่งซ้าย: $left_bank'),
                //     const SizedBox(width: 5),
                //     right_bank == null
                //         ? MainStyle().showProgressBar()
                //         : Text('ตลิ่งขวา: $right_bank'),
                //     const SizedBox(height: 10),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ground_level == null
                //         ? MainStyle().showProgressBar()
                //         : Text('ท้องน้ำ: $ground_level'),
                //     const SizedBox(width: 5),
                //     water == null
                //         ? MainStyle().showProgressBar()
                //         : Text('ระดับน้ำ: $water'),
                //     const SizedBox(height: 10),
                //   ],
                // ),
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
