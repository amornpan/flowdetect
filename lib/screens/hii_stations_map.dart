import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../utility/map_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class HiiStationMap extends StatefulWidget {
  const HiiStationMap({Key? key}) : super(key: key);

  @override
  State<HiiStationMap> createState() => _HiiStationMapState();
}

class _HiiStationMapState extends State<HiiStationMap> {
  late double screenWidth;
  late double screenHigh;

  DateTime? date;
  // late DateTime time;
  String? time;
  double? water;
  double? lat;
  double? lng;

  late CameraPosition position;

  double? latitudeDevice;
  double? longitudeDevice;

  Future<void> getDataWLNortheastLasted(
    String user,
    String pass,

  ) async {
    String url = "https://wea.hii.or.th:3005/getDataWLNortheastLasted";
    var uri = Uri.parse(url);
    var parsedJson;
    var jsonData;
    Map<dynamic, dynamic> body = {'user': user, 'pass': pass};

    final response = await http.post(uri,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      jsonData = response.body;
      parsedJson = jsonDecode(jsonData);
      //debugPrint('${parsedJson.runtimeType} : $parsedJson');
      var dateformat = DateFormat('yyyy-MM-dd');
      date = dateformat.parse(parsedJson['data'][11]['date']);
      //time = DateTime.parse(parsedJson['data'][11]['time']);
      time = parsedJson['data'][11]['time'];
      lat = double.parse(parsedJson['data'][11]['lat']);
      lng = double.parse(parsedJson['data'][11]['lng']);
      water = parsedJson['data'][11]['water'];

      debugPrint(
          'date = $date, time = $time, water = $water, lat= $lat, lng = $lng');

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataWLNortheastLasted('WLNortheast', 'ce0301505244265d13b8d53eb63126e1');
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
      onPressed: () {
        Navigator.pushNamed(context, '/hiiStationMap');
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    final routeData =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final stationCode = routeData['stationCode'];

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
                      Text('วันที่: $date'),
                      const SizedBox(width: 5),
                      Text('เวลา: $time'),
                      const SizedBox(width: 5),
                      Text('รหัสสถานี: $stationCode'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ค่าระดับน้ำ: $water'),
                      const SizedBox(width: 5),
                      Text('Lat: $lat'),
                      const SizedBox(width: 5),
                      Text('Lng: $lng'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildMap(),
                  const SizedBox(height: 10),
                  nextButton(),
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
                markers: setDeviceMarker(),
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
