import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../utility/map_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:camera/camera.dart';
// import 'package:flowdetect/screens/camera_page.dart';

class HiiStationMap extends StatefulWidget {
  final String StationCodes;

  const HiiStationMap({Key? key, required this.StationCodes}) : super(key: key);

  @override
  State<HiiStationMap> createState() => _HiiStationMapState();
}

class _HiiStationMapState extends State<HiiStationMap> {
  String? StationCode;

  late double screenWidth;
  late double screenHigh;

  late dynamic returnStationCode;

  String? name;
  String? date;
  String? time;
  double? water;
  double? left_bank;
  double? right_bank;
  double? ground_level;
  double? lat;
  double? lng;

  late CameraPosition position;

  double? latitudeDevice;
  double? longitudeDevice;

  Future<void> getDataWLNortheastLasted(
    String user,
    String pass,
    String stationcode,
  ) async {
    String url = "https://wea.hii.or.th:3005/getDataWLNortheastLasted";
    var uri = Uri.parse(url);
    late var parsedJson;
    late String jsonData;
    Map<dynamic, dynamic> body = {'user': user, 'pass': pass};
    var intLastIndex = 0;

    final response = await http.post(uri,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      // jsonData = response.body;
      // parsedJson = jsonDecode(jsonData);
      setState(
        () {
          jsonData = response.body;
          parsedJson = jsonDecode(jsonData);
        },
      );

      for (var i = 0; i < parsedJson['data'].length; i++) {
        var obj = parsedJson['data'][i];
        for (var key in obj.keys) {
          var value = obj[key];
          //debugPrint('key = $key, value = $value');
          if (value == stationcode) {
            intLastIndex = i;
            break;
          }
        }
      }
      date = parsedJson['data'][intLastIndex]['date'];
      name = parsedJson['data'][intLastIndex]['name'];
      time = parsedJson['data'][intLastIndex]['time'];
      lat = double.parse(parsedJson['data'][intLastIndex]['lat']);
      lng = double.parse(parsedJson['data'][intLastIndex]['lng']);
      left_bank = parsedJson['data'][intLastIndex]['left_bank'];
      right_bank = parsedJson['data'][intLastIndex]['right_bank'];
      ground_level = parsedJson['data'][intLastIndex]['ground_level'];
      water = parsedJson['data'][intLastIndex]['water'];

      // debugPrint(
      //     'name = $name, \ndate = $date, \ntime = $time, \nwater = $water, \nlat= $lat, \nlng = $lng');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    StationCode = widget.StationCodes;
    super.initState();
    getDataWLNortheastLasted(
        'WLNortheast', 'ce0301505244265d13b8d53eb63126e1', StationCode!);
    checkPermissionEnable();
  }

  Future<void> checkPermissionEnable() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      debugPrint('location opened');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          mapDialog(
            context,
            "การอนุญาตให้แชร์ตำแหน่งถูกปิด",
            "จำเป็นต้องแชร์ตำแหน่งก่อนใช่งาน",
          );
        } else {
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          mapDialog(
            context,
            "การอนุญาตให้แชร์ตำแหน่งถูกปิด",
            "จำเป็นต้องแชร์ตำแหน่งก่อนใช่งาน",
          );
        } else {
          findLatLng();
        }
      }
    } else {
      debugPrint('location closed');
      mapDialog(
        context,
        "การเข้าถึงตำแหน่งถูกปิด",
        "กรุณาเปิดการเข้าถึงตำแหน่งก่อนใช่งาน",
      );
    }
  }

  Future<void> findLatLng() async {
    debugPrint('findLatLng() work');
    Position? position = await findPosition();
    setState(() {
      latitudeDevice = position!.latitude;
      longitudeDevice = position.longitude;
      debugPrint('lat = $latitudeDevice lng= $longitudeDevice');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Widget nextButton() {
    return ElevatedButton(
      // onPressed: () {
      //   Navigator.pushNamed(context, '/hiiStationMap');
      // },

      // onPressed: () async {
      //   await availableCameras().then((value) => Navigator.push(context,
      //       MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
      // },

      onPressed: () {
        Navigator.pushNamed(
          context,
          '/particleSizeSelect',
          arguments: <String, dynamic>{
            'stationCode': returnStationCode,
            'name': name,
            'date': date,
            'time': time,
            'water': water,
            'left_bank': left_bank,
            'right_bank': right_bank,
            'ground_level': ground_level,
            'lat': lat,
            'lng': lng,
          },
        );
      },

      // Open camera
      // onPressed: () async {
      //   await availableCameras().then((value) => Navigator.push(context,
      //       MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
      // },

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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    final routeData =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    //final stationCode = routeData['stationCode'];
    returnStationCode = routeData['stationCode'];

    getDataWLNortheastLasted(
        'WLNortheast', 'ce0301505244265d13b8d53eb63126e1', returnStationCode);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สถานีโทรมาตรวัดระดับน้ำ สสน.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.blue.shade500,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Colors.blue.shade500,
              child: const ClipPath(),
              height: screenHigh,
              width: screenWidth,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      returnStationCode == null
                          ? MainStyle().showProgressBar()
                          : Text('รหัสสถานี: $returnStationCode'),
                      const SizedBox(width: 5),
                      name == null
                          ? MainStyle().showProgressBar()
                          : Text('ชื่อสถานี: $name'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      date == null
                          ? MainStyle().showProgressBar()
                          : Text('วันที่: $date'),
                      const SizedBox(width: 5),
                      time == null
                          ? MainStyle().showProgressBar()
                          : Text('เวลา: $time'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      lat == null
                          ? MainStyle().showProgressBar()
                          : Text('Lat: $lat'),
                      const SizedBox(width: 5),
                      lng == null
                          ? MainStyle().showProgressBar()
                          : Text('Lng: $lng'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      left_bank == null
                          ? MainStyle().showProgressBar()
                          : Text('ตลิ่งซ้าย: $left_bank'),
                      const SizedBox(width: 5),
                      right_bank == null
                          ? MainStyle().showProgressBar()
                          : Text('ตลิ่งขวา: $right_bank'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ground_level == null
                          ? MainStyle().showProgressBar()
                          : Text('ท้องน้ำ: $ground_level'),
                      const SizedBox(width: 5),
                      water == null
                          ? MainStyle().showProgressBar()
                          : Text('ระดับน้ำ: $water'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ตรวจสอบตำแหน่งของท่านกับสถานีที่เลือก?',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Color(0xff0064b7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildMap(),
                  const SizedBox(height: 10),
                  nextButton(),
                  const SizedBox(height: 15),
                  const Text('* ให้แน่ใจว่าตำแหน่งของท่านอยู่ตรงกับสถานี')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Set<Marker> setDeviceMarker() => <Marker>{
        Marker(
          draggable: false,
          markerId: const MarkerId('deviceID'),
          position: LatLng(latitudeDevice!, longitudeDevice!),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(
            title: 'คุณอยู่ที่นี่',
            //snippet: 'lat = $latitude_device, lng = $longitude_device',
          ),
        )
      };

  Widget buildMap() => Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
        // color: Colors.grey,
        width: double.infinity,
        height: 250,
        child: latitudeDevice == null
            ? MainStyle().showProgressBar()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    latitudeDevice!,
                    longitudeDevice!,
                  ),
                  zoom: 17,
                  bearing: 30,
                ),
                mapType: MapType.normal,
                onMapCreated: (controller) {},
                myLocationEnabled: true,
                //markers: setDeviceMarker(),
              ),
      );
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

    // Bottom
    // path0.moveTo(0, size.height * 1.0007194);
    // path0.lineTo(0, size.height * 0.8820144);
    // path0.quadraticBezierTo(size.width * 0.1937556, size.height * 0.9706906,
    //     size.width * 0.3361111, size.height * 0.9690647);
    // path0.cubicTo(
    //     size.width * 0.4723556,
    //     size.height * 0.9600719,
    //     size.width * 0.6323556,
    //     size.height * 0.9025180,
    //     size.width * 0.7922222,
    //     size.height * 0.9043165);
    // path0.quadraticBezierTo(size.width * 0.8812444, size.height * 0.9070216,
    //     size.width, size.height * 0.9420863);
    // path0.lineTo(size.width, size.height * 1.0021583);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
