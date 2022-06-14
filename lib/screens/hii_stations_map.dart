import 'package:flowdetect/utility/main_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../utility/map_dialog.dart';

class HiiStationMap extends StatefulWidget {
  const HiiStationMap({Key? key}) : super(key: key);

  @override
  State<HiiStationMap> createState() => _HiiStationMapState();
}

class _HiiStationMapState extends State<HiiStationMap> {
  late double screenWidth;
  late double screenHigh;

  late double latitude_station;
  late double longitude_station;
  late CameraPosition position;

  @override
  void initState() {
    super.initState();
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
                  const ListTile(
                    leading: Icon(Icons.water_sharp),
                    title: Text('วันเวลา'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.water_sharp),
                    title: Text('ค่าระดับน้ำ'),
                  ),
                  const SizedBox(height: 10),
                  //showMap(),
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

  Set<Marker> markerSet() {
    return <Marker>[
      Marker(
        draggable: false,
        markerId: const MarkerId('StationsMarker'),
        position: LatLng(latitude_station, latitude_station),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow: const InfoWindow(
          title: "สถานีเมืองขอนแก่น",
          snippet: "CHI006 เมืองขอนแก่น",
        ),
      )
    ].toSet();
  }

  Container showMap() {
    latitude_station = 16.3259376;
    longitude_station = 102.7859904;

    LatLng latLngStation = LatLng(latitude_station, longitude_station);
    position = CameraPosition(
      target: latLngStation,
      zoom: 17,
    );

    return Container(
      margin: const EdgeInsets.all(15),
      height: 300,
      child: latitude_station == null
          ? MainStyle().showProgressBar()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: markerSet(),
            ),
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
