import 'package:camera/camera.dart';
import 'package:flowdetect/models/hii_station_model.dart';
import 'package:flowdetect/screens/camera_page.dart';
import 'package:flowdetect/utility/dialog.dart';
import 'package:flowdetect/utility/sqlite_management.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ParticleSizeSelect extends StatefulWidget {
  const ParticleSizeSelect({Key? key}) : super(key: key,);

  @override
  State<ParticleSizeSelect> createState() => _ParticleSizeSelectState();
}

class _ParticleSizeSelectState extends State<ParticleSizeSelect> {
  late double screenWidth;
  late double screenHigh;

  String? initCamera;
  List<CameraDescription>? cameras;

  String? name;
  String? date;
  String? time;
  double? water;
  double? left_bank;
  double? right_bank;
  double? ground_level;
  double? lat;
  double? lng;
  dynamic stationCode;

  bool particleSelect = false;
  double particleSize = 0.0;

  int? postgresid;

  var clicks = <bool>[
    false,
    false,
    false,
  ];
  Color colorClick = const Color.fromARGB(255, 7, 72, 125);

  bool load = true;
  var hiiStationModels = <HiiStationModel>[];

  Future<void> processReadData() async {
    if (hiiStationModels.isNotEmpty) {
      hiiStationModels.clear();
    }

    await SQLiteManagement().readHiiStation().then((value) {
      hiiStationModels = value;
      load = false;
      setState(() {});
    });
  }

  // Future<void> processSaveSqlite() async {

  //   HiiStationModel hiiStationModel = HiiStationModel(
  //     idHii: stationCode,
  //     name: name.toString(),
  //     date: date.toString(),
  //     time: time.toString(),
  //     water: double.parse(water.toString()),
  //     leftBank: double.parse(left_bank.toString()),
  //     rightBank: double.parse(right_bank.toString()),
  //     groundBevel: double.parse(ground_level.toString()),
  //     lat: double.parse(lat.toString()),
  //     lng: double.parse(lng.toString()),
  //     particleSize: particleSize,
  //     //recordDataTime: dateTime.toString(),
  //     devicePathStorage: '',
  //     surfaceVelocity: 0.0,
  //     averageVelocyty: 0.0,
  //     flowrate: 0.0,
  //     flagStatus: 0,
  //     // chanel: 'chanel',
  //     // pathStorage: pathRecordVideo!,
  //   );

  //   await SQLiteManagement()
  //       .insertHiiStation(hiiStationModel: hiiStationModel)
  //       .then((value) {
  //     print('##13july processSaveSqlite Success');
  //     print(processReadData());
  //   });
  // }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    final routeData =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    stationCode = routeData['stationCode'];
    name = routeData['name'];
    date = routeData['date'];
    time = routeData['time'];
    water = routeData['water'];
    left_bank = routeData['left_bank'];
    right_bank = routeData['right_bank'];
    ground_level = routeData['ground_level'];
    lat = routeData['lat'];
    lng = routeData['lng'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สถานีโทรมาตรวัดระดับน้ำ สสน.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'กรุณาเลือกขนาดของวัตถุที่ใช้ลอย',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff0064b7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Particle Image
              Column(
                children: [
                  particle100(),
                  const SizedBox(height: 10),
                  particle50(),
                  const SizedBox(height: 10),
                  particle20(),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'ขนาด Particle ที่เลือก = ' + particleSize.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff0064b7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              nextButton(),
              const SizedBox(height: 10),
              const Text('* เลือกขนาดตามความกว้างของลำน้ำ'),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor({required int index}) {
    for (var i = 0; i < clicks.length; i++) {
      clicks[i] = false;
    }
    clicks[index] = true;
    setState(() {});
  }

  Widget particle100() {
    return ElevatedButton(
      child: const Text(
        '100 cm',
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        changeColor(index: 0);
        setState(() {
          particleSelect = true;
          particleSize = 100.0;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            clicks[0] ? colorClick : Color.fromARGB(255, 71, 163, 239),
        fixedSize: const Size(120, 120),
        shape: const CircleBorder(),
      ),
    );
  }

  Widget particle50() {
    return ElevatedButton(
      child: const Text(
        '50 cm',
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        changeColor(index: 1);
        setState(() {
          particleSelect = true;
          particleSize = 50.0;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            clicks[1] ? colorClick : Color.fromARGB(255, 71, 163, 239),
        fixedSize: const Size(100, 100),
        shape: const CircleBorder(),
      ),
    );
  }

  Widget particle20() {
    return ElevatedButton(
      child: const Text(
        '20 cm',
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        changeColor(index: 2);
        setState(() {
          particleSelect = true;
          particleSize = 20.0;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            clicks[2] ? colorClick : Color.fromARGB(255, 71, 163, 239),
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () async {
        DateTime dateTime = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
        if (particleSize == 0.0) {
          normalDialog(
              context, "ยังไม่ได้เลือกขนาดวัตถุ", "กรุณาเลือกขนาดวัตถุ");
        } else {
          Map<String, dynamic> map = {};
          map['idHii'] = stationCode;
          map['name'] = name;
          map['date'] = date;
          map['time'] = time;
          map['water'] = water;
          map['leftBank'] = left_bank;
          map['rightBank'] = right_bank;
          map['groundBevel'] = ground_level;
          map['lat'] = lat;
          map['lng'] = lng;
          map['particleSize'] = particleSize;
          map['recordDataTime'] = formattedDate;
          map['devicePathStorage'] = '-';

          FormData formData = FormData.fromMap(map);

          String path =
              'http://113.53.253.55:5001/hiistations_api_first_record_data';

          await Dio()
              .post(
            path,
            data: formData,
          )
              .then(
            (value1) {
              postgresid = int.tryParse(value1.toString());
              print('##13july value from api ==> $postgresid');

              //1. showdialog
              // normalDialog(context, "บันทึกข้อมูลเรียบร้อย",
              //     "ถัดไปคือการบันทึกไฟล์วีดีโอ");

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("บันทึกข้อมูลเรียบร้อย"),
                    actions: <Widget>[
                      OutlinedButton(
                        child: const Text("ถัดไป"),
                        onPressed: () async {
                          print('### $postgresid');

                          await availableCameras().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return CameraPage(
                                    //cameras: value == null ? value = 0 : value,
                                    cameras: value,
                                    postgresids: postgresid,
                                    particleSizes: particleSize,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );

              //2. save return id to local storage

              //3. navigator to camera
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ShowVideoPlayer(
              //       urlVideo: value.toString(),
              //     ),
              //   ),
              // );
            },
          ).catchError(
            (error) {
              print('##13july error from api ==> $error');
            },
          );

          //Save Value to SQLiteDB
          // idHii: stationCode,
          // name: name.toString(),
          // date: date.toString(),
          // time: time.toString(),
          // water: double.parse(water.toString()),
          // leftBank: double.parse(left_bank.toString()),
          // rightBank: double.parse(right_bank.toString()),
          // groundBevel: double.parse(ground_level.toString()),
          // lat: double.parse(lat.toString()),
          // lng: double.parse(lng.toString()),
          // particleSize: particleSize,
          // recordDataTime: dateTime.toString(),
          // devicePathStorage: '',
          // surfaceVelocity: 0.0,
          // averageVelocyty: 0.0,
          // flowrate: 0.0,
          // flagStatus: 0,

          //processSaveSqlite();

          // await availableCameras().then(
          //   (value) => Navigator.push(
          //     context,
          //     //MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
          //     MaterialPageRoute(
          //       builder: (_) {
          //         return CameraPage(
          //           cameras: value,
          //         );
          //       },
          //     ),
          //   ),
          // );
        }
      },
      child: const Text("ต่อไป"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          shadowColor: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          primary: const Color.fromRGBO(41, 168, 223, 1),
          textStyle: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
            fontFamily: "Orbitron",
          )),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TOP
    final Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.2017986);
    path0.quadraticBezierTo(size.width * 0.0516667, size.height * 0.1122302,
        size.width * 0.2188889, size.height * 0.1003597);
    path0.cubicTo(
        size.width * 0.3405556,
        size.height * 0.0974820,
        size.width * 0.6283333,
        size.height * 0.1330935,
        size.width * 0.7777778,
        size.height * 0.1320144);
    path0.quadraticBezierTo(size.width * 0.9111111, size.height * 0.1301295,
        size.width, size.height * 0.0848921);
    path0.lineTo(size.width, 0);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
