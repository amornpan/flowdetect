import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'hii_station_second_preview.dart';

final List<String> list = <String>['50', '40', '30', '20'];

class HiiStationVideoSetting extends StatefulWidget {
  final int? postgresids;
  final String? imgPreviews;
  final String? videoNames;
  final int? y1Green;
  final int? y2Red;
  final int? x1Left;
  final int? x2Right;
  final double? particleSizes;

  const HiiStationVideoSetting({
    Key? key,
    this.postgresids,
    this.imgPreviews,
    this.videoNames,
    this.y1Green,
    this.y2Red,
    this.x1Left,
    this.x2Right,
    this.particleSizes,
  }) : super(key: key);

  @override
  State<HiiStationVideoSetting> createState() => _HiiStationVideoSettingState();
}

class _HiiStationVideoSettingState extends State<HiiStationVideoSetting> {
  int? postgresIntid;
  String? imgPreview;
  int? y1Green;
  int? y2Red;
  int? x1Left;
  int? x2Right;
  String videoName = "";
  double? particleSize;

  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
    imgPreview = widget.imgPreviews;
    videoName = widget.videoNames!;
    y1Green = widget.y1Green;
    y2Red = widget.y2Red;
    x1Left = widget.x1Left;
    x2Right = widget.x2Right;
    particleSize = widget.particleSizes;

    //print('###imgPreview $imgPreview');
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.swipe_left_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/userService', (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
        title: const Text('Setting'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ปรับแต่งผลลัพธ์สำหรับการคำนวน',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff0064b7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.network(imgPreview!),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ค่าเกณฑ์ (threshold): ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.deepPurple, fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       'เส้นอ้างอิงบน : ',
                    //       style: TextStyle(
                    //         fontSize: 20.0,
                    //         color: Colors.green,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const SizedBox(height: 10),
                    //     SizedBox(
                    //       width: 200,
                    //       height: 50,
                    //       child: TextField(
                    //         controller: y1GreenController,
                    //         obscureText: false,
                    //         decoration: const InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           labelText: 'เส้นอ้างอิงบน',
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(height: 20),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       'เส้นอ้างอิงล่าง : ',
                    //       style: TextStyle(
                    //         fontSize: 20.0,
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const SizedBox(height: 10),
                    //     SizedBox(
                    //       width: 200,
                    //       height: 50,
                    //       child: TextField(
                    //         controller: y2RedController,
                    //         obscureText: false,
                    //         decoration: const InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           labelText: 'เส้นอ้างล่าง',
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> map = {};
                        map['id'] = postgresIntid;
                        map['thresholdvalue'] =
                            dropdownValue == '50' ? '50' : dropdownValue;
                        map['y1Greens'] = y1Green;
                        map['y2Reds'] = y2Red;
                        map['videoName'] = 'output_' + videoName + '.mp4';
                        map['x1Lefts'] = x1Left;
                        map['x2Rights'] = x2Right;

                        // print("## map['id']= ${map['id']}");
                        // print("## map['thresholdvalue']= ${map['thresholdvalue']}");
                        // print("## map['y1Greens']= ${map['y1Greens']}");
                        // print("## map['y2Reds']= ${map['y2Reds']}");
                        // print("## map['x1Lefts']= ${map['x1Lefts']}");
                        // print("## map['x2Rights']= ${map['x2Rights']}");
                        // print("## map['videoName']= ${map['videoName']}");

                        FormData formData = FormData.fromMap(map);
                        String path =
                            'http://113.53.253.55:5001/hiistations_api3';
                        await Dio().post(path, data: formData,
                          options: Options(
                            followRedirects: false,
                            // will not throw errors
                            validateStatus: (status) => true,
                          ),
                        ).then(
                          (value) async {
                            await pr.show();

                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return HiiStationSecondPreview(
                                    videoNames: videoName,
                                    y1Green: y1Green,
                                    y2Red: y2Red,
                                    x1Left: x1Left!.toInt(),
                                    x2Right: x2Right!.toInt(),
                                    postgresids: postgresIntid,
                                    thresholdvalues: dropdownValue == '50'
                                        ? int.parse('50')
                                        : int.parse(dropdownValue),
                                    particleSizes: particleSize);
                              },
                            ), (route) => false);

                            Future.delayed(const Duration(seconds: 3))
                                .then((value) async => await pr.hide());
                          },
                        ).catchError(
                          (error) {
                            print('##10aug error $error');
                          },
                        );
                      },
                      child: const Text('ยืนยันการตั้งค่า'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
